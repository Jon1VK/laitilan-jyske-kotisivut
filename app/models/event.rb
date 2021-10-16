# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  description      :text             not null
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
  validates :description, presence: true
end
