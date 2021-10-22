class PracticeSpider < Kimurai::Base
  BASE_URL = 'https://www.suomisport.fi'

  @name = "practice_spider"
  @engine = :selenium_chrome
  @start_urls = ['https://www.suomisport.fi/events?dateTimeRangeEnd=&dateTimeRangeStart=&organizers=%5B%7B%22id%22%3A19796%2C%22organizationType%22%3A%22CLUB%22%7D%5D&purpose=&searchTerm=&sportIds&tagIds']
  @config = {
    before_request: {
      delay: 1..3,
    }
  }

  def parse(response, params)
    count = 0
    loop do
      browser.execute_script("window.scrollBy(0,10000)")
      sleep 2
      response = browser.current_response
      new_count = response.css('.eventcard').count
      if new_count == count
        logger.info "Pagination is done"
        break
      else
        count = new_count
        logger.info "Continue scrolling, current event count is #{count}"
      end
    end

    response.css('.eventcard').each do |card|
      practice = {}
      practice[:title] = card.css('.eventcardtitle').text
      practice[:location] = card.at('.location-item').text
      practice[:registration_url] = BASE_URL + card.at('a')['href']
      request_to :parse_additional_info, url: practice[:registration_url], data: { practice: practice }
    end
  end

  def parse_additional_info(response, params)
    button = nil
    loop do
      sleep 2
      response = browser.current_response
      button = response.at('.eventinstances button')
      if button
        browser.click_button button.text
        logger.info "Loading more event instances"
      else
        logger.info "All event instances loaded"
        break
      end
    end

    practice = params[:data][:practice]
    practice[:description] = response.at('.descriptioninner').text
    practice[:registration_due] = response.at('.registration .additionaldetails span')&.text
    practice_instances = response.css('.eventinstance')

    if practice_instances.empty?
      practice[:start_time], practice[:end_time] = parse_datetimes(response.at('.eventdetailsblock').text)
      event = Event.find_or_create_by(title: practice[:title], start_time: Time.zone.parse(practice[:start_time]))
      event.update(**practice)
    else
      practice_instances.each do |practice_instance|
        practice[:start_time], practice[:end_time] = parse_datetimes(practice_instance.at('span').text)
        event = Event.find_or_create_by(title: practice[:title], start_time: Time.zone.parse(practice[:start_time]))
        event.update(**practice)
      end
    end
  end

  def parse_datetimes(datetimes)
    m = datetimes.match(/(?<start_day>\d+)\.(?<start_month>\d+)\.(?<start_year>\d+)[^\d]+(?<start_hour>\d+):(?<start_minute>\d+)[^\d]+(?:(?<end_day>\d+)\.(?<end_month>\d+)\.(?<end_year>\d+)[^\d]+)?(?<end_hour>\d+):(?<end_minute>\d+)/)
    start_day = m[:start_day]
    start_month = m[:start_month]
    start_year = m[:start_year]
    start_hour = m[:start_hour]
    start_minute = m[:start_minute]
    end_day = m[:end_day].nil? ? m[:start_day] : m[:end_day]
    end_month = m[:end_month].nil? ? m[:start_month] : m[:end_month]
    end_year = m[:end_year].nil? ? m[:start_year] : m[:end_year]
    end_hour = m[:end_hour]
    end_minute = m[:end_minute]
    return [
      "#{start_day}.#{start_month}.#{start_year} #{start_hour}:#{start_minute}",
      "#{end_day}.#{end_month}.#{end_year} #{end_hour}:#{end_minute}"
    ]
  end
end
