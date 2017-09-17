class Category < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :items
  extend FriendlyId
  friendly_id :title

  def self.all_for_nav
    @all_for_nav ||= Category.all
  end

  def self.items_in_category
    categories = Category.select('categories.id, count(items.id) as quantity').
                  left_outer_joins(:items).
                  group(:id)
    final = Hash.new(0)

    categories.each do |category|
      cat = Category.find(category.id).title
      final[cat] = category.quantity
    end
    final
  end
end
