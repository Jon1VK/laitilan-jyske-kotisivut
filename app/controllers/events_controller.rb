class EventsController < ApplicationController
  # GET /tapahtumakalenteri?year=2021&month=10
  def index
    @month = params[:month]&.to_i || Date.today.month
    @year = params[:year]&.to_i || Date.today.year
    @dates = (Date.new(@year, @month).beginning_of_week..Date.new(@year, @month).end_of_month.end_of_week).to_a
    @events = Event.events_by_year_and_month(@year, @month)
  end

  # GET /tapahtumakalenteri/1
  def show
    @event = Event.find(params[:id])
  end
end
