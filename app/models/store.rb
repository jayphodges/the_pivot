class Store < ApplicationRecord
  enum status: %w(pending approved declined)
  has_many :user_roles
  has_many :users, through: :user_roles
end
