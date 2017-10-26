class Item < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, :price, :category_id, presence: true

  belongs_to :category
  belongs_to :store
  has_many :orders_items
  has_many :orders, through: :orders_items

  enum status: %w(active retired)

  mount_uploader :image, ImageUploader

  def formatted_price
    sprintf('%.2f', price)
  end

  def self.top_selling_items
    joins(:orders_items, :orders)
    .merge(Order.completed).group('items.id')
    .order('sum_orders_items_unit_price DESC')
    .sum('orders_items.unit_price')
  end

  def self.most_sold_items
    joins(:orders_items, :orders)
    .merge(Order.completed)
    .group('items.id')
    .order('count_items_id DESC')
    .count('items.id')
  end

end
