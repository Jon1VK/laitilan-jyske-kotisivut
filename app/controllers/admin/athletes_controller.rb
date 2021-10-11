module Admin
  class AthletesController < Admin::ApplicationController
    def default_sorting_attribute
      :firstname
    end

    def find_resource(param)
      Athlete.friendly.find(param)
    end
  end
end
