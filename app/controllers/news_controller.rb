class NewsController < ApplicationController
  # GET /uutiset
  def index
    @news = News.order(published_at: :desc).page(params[:page]).per(10)
  end

  # GET /uutiset/1
  def show
    @news = News.friendly.find(params[:id])
  end
end
