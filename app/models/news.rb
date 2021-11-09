# == Schema Information
#
# Table name: news
#
#  id           :bigint           not null, primary key
#  published_at :date             not null
#  slug         :string           not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_news_on_slug     (slug) UNIQUE
#  index_news_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class News < ApplicationRecord
  default_scope { order(published_at: :desc) }

  # Associations
  belongs_to :user
  has_rich_text :content

  # Validations
  validates :title, presence: true, uniqueness: { scope: :published_at }
  validates :published_at, presence: true

  # Add human friendly slug
  extend FriendlyId
  friendly_id :to_slug, use: :slugged

  # Methods
  def to_slug
    "#{published_at} #{title}"
  end

  def self.most_recent_news
    News.order(published_at: :desc).limit(2)
  end
end
