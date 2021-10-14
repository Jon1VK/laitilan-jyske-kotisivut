module Admin
  class RecordsController < Admin::ApplicationController
    def default_sorting_attribute
      :reviewed
    end
  end
end
