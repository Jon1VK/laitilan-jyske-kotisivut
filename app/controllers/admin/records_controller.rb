module Admin
  class RecordsController < Admin::ApplicationController
    def default_sorting_attribute
      :league
    end
  end
end
