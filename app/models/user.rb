class User < ApplicationRecord
  has_secure_password
  has_many :orders
  validates :username, uniqueness: true, presence: true
  validates :password_digest, :full_name, :address, presence: true

  enum role: %w(default admin)
end
