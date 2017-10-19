class Store < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  
  enum status: %w(pending approved declined)
end
