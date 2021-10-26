class StaticController < ApplicationController
  def index
    @events = Event.upcoming_events
    @news = News.most_recent_news
  end
end
