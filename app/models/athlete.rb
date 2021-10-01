# == Schema Information
#
# Table name: athletes
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  event                  :string
#  failed_attempts        :integer          default(0), not null
#  firstname              :string           not null
#  lastname               :string           not null
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  slug                   :string           not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_athletes_on_email                 (email) UNIQUE
#  index_athletes_on_reset_password_token  (reset_password_token) UNIQUE
#  index_athletes_on_slug                  (slug) UNIQUE
#  index_athletes_on_unlock_token          (unlock_token) UNIQUE
#
class Athlete < ApplicationRecord
  # Authentication implementation with devise
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :lockable
  
  # Add human friendly slug
  extend FriendlyId
  friendly_id :fullname, use: :slugged

  # Validations
  validates :firstname, presence: true, uniqueness: { scope: :lastname }
  validates :lastname, presence: true

  # Associations
  has_rich_text :content

  # Methods
  def fullname
    "#{firstname} #{lastname}"
  end
end
