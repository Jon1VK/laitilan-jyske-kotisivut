class NewsController < ApplicationController
  # GET /uutiset
  def index
    @news = News.order(published_at: :desc).page(params[:page]).per(8)
  end

  # GET /uutiset/1
  def show
    @news = News.friendly.find(params[:id])
  end

  # GET /uutiset/page/1
  def page
    @news = News.order(published_at: :desc).page(params[:id]).per(8)
    respond_to :turbo_stream
  end
end
