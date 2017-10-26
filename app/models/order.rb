class Order < ApplicationRecord
  belongs_to :user
  belongs_to :store, optional: true
  has_many :orders_items
  has_many :items, through: :orders_items
  validates :user_id, :status, presence: true

  enum status: %w(ordered paid cancelled completed)

  def total_order_price
  	sanitize_price(orders_items.sum(:unit_price))
  end

  def item_price(item)
    sanitize_price(orders_items.find_by(order_id: self.id, item_id: item.id).unit_price)
  end

  def item_quantity(item)
  	id = item.id
  	items.where(id: id).count
  end

  def item_subtotal(item)
  	id = item.id
  	sanitize_price(orders_items.where(item_id: id).sum(:unit_price))
  end

  def sanitize_price(price)
    sprintf('%.2f', price)
  end

  def add_items(cart)
    cart.contents.each do |item_id, quantity|
      item = Item.find(item_id)
      quantity.to_i.times {items << item}
    end
  end

  def add_unit_price_to_join(cart)
    cart.contents.each do |item_id, quantity|
      item = Item.find(item_id)
      orders_items.where(item_id: item_id).update(unit_price: item.price)
    end
  end

  def self.orders_by_month
    Order.group_by_month("orders.created_at::date").count
  end

  def self.orders_by_day_of_week
    Order.group_by_day_of_week(:created_at, format: "%a").count
  end
end
