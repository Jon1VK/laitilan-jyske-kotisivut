class StaticController < ApplicationController
  def index
    @events = Event.upcoming_events
  end
end
