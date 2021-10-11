module Admin
  class RecordsController < Admin::ApplicationController
    def default_sorting_attribute
      :league
    end

    def disciplines
      @disciplines = Record::DISCIPLINES_BY_LEAGUE[params[:league]] || []
      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end
