class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password_digest, presence: true
  has_secure_password :validations => true

  has_many :party_users
  has_many :parties, through: :party_users

  def self.email_list
    pluck(:email)
  end
end
