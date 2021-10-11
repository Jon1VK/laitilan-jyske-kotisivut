module Admin
  class AthletesController < Admin::ApplicationController
    def find_resource(param)
      Athlete.friendly.find(param)
    end
  end
end
