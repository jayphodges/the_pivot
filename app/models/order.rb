class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_items
  has_many :items, through: :orders_items

  enum status: %w(ordered paid cancelled completed)

  def total_order_price
  	items.sum(:price)
  end

  def item_quantity(item)
  	id = item.id
  	items.where(id: id).count
  end

  def item_subtotal(item)
  	id = item.id
  	items.where(id: id).sum(:price)
  end

  def add_items(cart)
    cart.contents.each do |item_id, quantity|
      item = Item.find(item_id)
      quantity.times {items << item}
    end
  end

end
