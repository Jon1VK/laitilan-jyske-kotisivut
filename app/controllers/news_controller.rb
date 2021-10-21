class NewsController < ApplicationController
  # GET /uutiset
  def index
    @news = News.all
  end

  # GET /uutiset/1
  def show
    @news = News.find(params[:id])
  end
end
