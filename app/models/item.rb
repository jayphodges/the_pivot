class Item < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, :price, :image, :category_id, presence: true

  belongs_to :category

  def formatted_price
    sprintf('%.2f', price)
  end
end
