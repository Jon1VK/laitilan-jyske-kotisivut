module Admin
  class EventsController < Admin::ApplicationController
    def default_sorting_attribute
      :start_time
    end
  end
end
