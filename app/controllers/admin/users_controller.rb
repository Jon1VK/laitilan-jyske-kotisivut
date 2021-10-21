module Admin
  class UsersController < Admin::ApplicationController
    def default_sorting_attribute
      :firstname
    end
  end
end
