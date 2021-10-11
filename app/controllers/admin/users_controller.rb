module Admin
  class UsersController < Admin::ApplicationController
    def default_sorting_attribute
      :email
    end
  end
end
