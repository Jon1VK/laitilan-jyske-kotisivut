class RecordsController < ApplicationController
  TITLEIZED_LEAGUES = Record::LEAGUES.map do |league|
    [league.parameterize, league]
  end.to_h

  TITLEIZED_DISCIPLINES = Record::DISCIPLINES.map do |discipline|
    [discipline.parameterize, discipline]
  end.to_h

  # GET /seuraennatykset
  def index
    @record = Record.new
  end

  # POST /seuraennatykset
  def create
    @record = Record.new(record_params)
    @record.reviewed = false

    if @record.save
      redirect_to records_url, notice: 'Uusi ennätys lähetetty tarkistettavaksi!'
    else
      flash.now[:alert] = 'Tarkista lomakkeen tiedot!'
      render :index, status: :unprocessable_entity
    end
  end

  # GET /seuraennatykset/pojat-9
  def league
    @league = TITLEIZED_LEAGUES[params[:league]]
    @records = Record.club_records_by_league(@league)
  end

  # GET /seuraennatykset/miehet/100m
  def top_ten
    @league = TITLEIZED_LEAGUES[params[:league]]
    @discipline = TITLEIZED_DISCIPLINES[params[:discipline]]
    @records = Record.top_ten_records_by_league_and_discipline(@league, @discipline)
  end

  # GET /seuraennatykset/disciplines?league=Miehet&discipline=100m
  def disciplines
    @disciplines = Record::DISCIPLINES_BY_LEAGUE[params[:league]] || []
    @discipline = params[:discipline]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def record_params
    params.require(:record).permit(:league, :discipline, :athlete, :result, :location, :achieved_at)
  end
end
