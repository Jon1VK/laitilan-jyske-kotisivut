class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
      if resource.is_a?(Athlete)
        athlete_url(resource)
      else
        super
      end
  end
end
