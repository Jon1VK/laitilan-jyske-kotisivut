# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  firstname              :string           not null
#  lastname               :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  default_scope { order(:firstname, :lastname) }

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Associations
  has_many :news

  # Validations
  validates :firstname, presence: true, uniqueness: { scope: :lastname }
  validates :lastname, presence: true

  # Methods
  def fullname
    "#{firstname} #{lastname}"
  end
end
