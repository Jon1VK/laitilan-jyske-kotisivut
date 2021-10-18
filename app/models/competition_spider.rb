class CompetitionSpider < Kimurai::Base
  BASE_URL = 'https://www.kilpailukalenteri.fi/'

  CELL_INDEXES = {
    dates: 0,
    title: 2,
    location: 3,
    registration_url: 2,
    registration_due: 4
  }

  @name = "Competition Spider"
  @engine = :mechanize
  @start_urls = [BASE_URL]
  @config = {
    skip_duplicate_requests: true,
    before_request: { delay: 1..3 }
  }

  def parse(response, params)
    date = Date.today
    day = date.day
    month = date.month
    year = date.year

    # Competition queries that we intend to scrape for competitions
    queries = [
      # Competitions in Varsinais-Suomi from current day forward
      "?cs=21&npa=#{day}&nka=#{month}&nva=#{year}&npl=00&nkl=00&nvl=00&acl%5B%5D=0&ns=0&ni=-1&nd=18&nl=0",
      # Finnish Championship competitions from current day forward
      "?cs=21&npa=#{day}&nka=#{month}&nva=#{year}&npl=00&nkl=00&nvl=00&acl%5B%5D=18&ns=0&ni=-1&nd=0&nl=0"
    ]

    queries.each do |query|
      request_to :parse_competitions, url: BASE_URL + query
    end
  end

  def parse_competitions(response, params)
    response.css('table.listaus tr.odd', 'table.listaus tr.even').each do |row|
      competition = {}
      cells = row.css('td')
      competition[:start_time], competition[:end_time] = parse_dates(cells[CELL_INDEXES[:dates]].text)
      competition[:title] = cells[CELL_INDEXES[:title]].text.squish
      competition[:location] = cells[CELL_INDEXES[:location]].text
      competition[:registration_url] = BASE_URL + cells[CELL_INDEXES[:registration_url]].at('a')['href']
      competition[:registration_due] = parse_datetime(cells[CELL_INDEXES[:registration_due]].text)
      request_to :parse_competition_description, url: competition[:registration_url], data: { competition: competition }
    end
  end

  def parse_competition_description(response, params)
    competition = params[:data][:competition]
    competition[:description] = response
      .at('table.listaus tr.even:nth-of-type(2)')
      .text.split("Sarjat/Lajit")[1]
      .strip.split("\n\n").join("\n")
    event = Event.find_or_create_by(title: competition[:title], start_time: Time.parse(competition[:start_time]))
    event.update(**competition)
  end

  def parse_dates(dates)
    m = dates.match(/(?<start_day>\d{2})\.(?:(?<start_month>\d{2})\.)?(?:-(?<end_day>\d{2})\.(?<end_month>\d{2})\.)?/)
    start_day = m[:start_day]
    start_month = m[:start_month].nil? ? m[:end_month] : m[:start_month]
    end_day = m[:end_day].nil? ? m[:start_day] : m[:end_day]
    end_month = m[:end_month].nil? ? m[:start_month] : m[:end_month]
    year = Date.today.year + (start_month.to_i < Date.today.month ? 1 : 0)
    return [
      "#{start_day}.#{start_month}.#{year}",
      "#{end_day}.#{end_month}.#{year}"
    ]
  end

  def parse_datetime(datetime)
    return nil if datetime == '-'
    m = datetime.match(/(?<day>\d{2})\.(?<month>\d{2})/)
    year = Date.today.year + (m[:month].to_i < Date.today.month ? 1 : 0)
    "#{m[:day]}.#{m[:month]}.#{year} 23:59"
  end
end
