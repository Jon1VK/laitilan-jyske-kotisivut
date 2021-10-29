# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  description      :text
#  end_time         :datetime         not null
#  location         :string           not null
#  registration_due :datetime
#  registration_url :string
#  start_time       :datetime         not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_events_on_title_and_start_time  (title,start_time) UNIQUE
#
class Event < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :start_time }
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def formatted_datetimes(format = :long)
    if start_time == end_time
      format == :short ? start_time.strftime('%-d.%-m.') : I18n.l(start_time.to_date, format: format)
    elsif start_time.to_date == end_time.to_date
      "#{I18n.l(start_time, format: format)} - #{end_time.strftime('%H.%M')}"
    else
      "#{I18n.l(start_time, format: :short)} - #{I18n.l(end_time, format: :short)}"
    end
  end

  def formatted_dates
    if start_time.to_date == end_time.to_date
      I18n.l(start_time.to_date, format: :long)
    else
      "#{I18n.l(start_time.to_date, format: :long)} - #{I18n.l(end_time, format: :long)}"
    end
  end

  def self.events_by_year_and_month(year, month)
    group_by_date(Event.where(start_time: DateTime.new(year, month)..DateTime.new(year, month).end_of_month).order(:start_time))
  end

  def self.upcoming_events(offset = 0)
    Event.where(start_time: offset.days.from_now..(offset + 7).days.from_now)
      .or(Event.where(start_time: offset.days.from_now.., registration_due: offset.days.from_now..(offset + 7).days.from_now))
      .order(:start_time)
  end

  def self.group_by_date(events)
    events.reduce(Hash.new { |h, k| h[k] = [] }) do |grouped_events, event|
      (event.start_time.to_date..event.end_time.to_date).each do |date|
        grouped_events[date] << event
      end
      grouped_events
    end
  end
end
