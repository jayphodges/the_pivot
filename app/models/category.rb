class Category < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :items
  extend FriendlyId
  friendly_id :title

  def self.all_for_nav
    @all_for_nav ||= Category.all
  end
end
