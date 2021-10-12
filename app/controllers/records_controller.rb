class RecordsController < ApplicationController
  TITLEIZED_LEAGUES = Record::LEAGUES.map do |league|
    [league.parameterize, league]
  end.to_h

  # GET /records
  def index
  end

  # GET /records/pojat-9
  def league
    @league = TITLEIZED_LEAGUES[params[:league]]
    @records = Record.records_by_league(@league)
  end
end
