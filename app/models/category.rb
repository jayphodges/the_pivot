class Category < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :items
  extend FriendlyId
  friendly_id :title
end
