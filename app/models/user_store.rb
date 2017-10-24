class UserStore < ApplicationRecord
  belongs_to :users
  belongs_to :stores
end
