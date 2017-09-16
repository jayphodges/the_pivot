class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_items
  has_many :items, through: :orders_items

  enum status: %w(ordered paid cancelled completed)

  def item_quantity(item)
  	id = item.id
  	items.where(id: id).count
  end

  def item_subtotal(item)
  	id = item.id
  	items.where(id: id).sum(:price)
  end

end
