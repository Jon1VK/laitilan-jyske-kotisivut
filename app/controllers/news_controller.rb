class NewsController < ApplicationController
  # GET /uutiset?page=1
  def index
    @news = News.with_rich_text_content_and_embeds.order(published_at: :desc).page(params[:page]).per(8)

    respond_to do |format|
      format.html
      format.turbo_stream { render :page }
    end
  end

  # GET /uutiset/1
  def show
    @news = News.friendly.find(params[:id])
  end
end
