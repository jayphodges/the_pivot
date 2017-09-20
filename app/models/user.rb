class User < ApplicationRecord
  has_secure_password
  has_many :orders
  validates :username, uniqueness: true, presence: true
  validates :password, presence: :true
  validates :address, presence: :true
  validates :full_name, presence: :true

  enum role: %w(default admin)
end
