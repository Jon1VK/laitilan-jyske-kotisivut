module Admin
  class NewsController < Admin::ApplicationController
    def create
      resource = resource_class.new(resource_params)
      resource.user = current_user
      authorize_resource(resource)

      if resource.save
        redirect_to(
          admin_news_path(resource),
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }, status: :unprocessable_entity
      end
    end

    def find_resource(param)
      News.friendly.find(param)
    end
  end
end
