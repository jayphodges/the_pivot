class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_api

  def orders_by_month
    render json: Order.orders_by_month
  end

  def orders_by_week
    render json: Order.orders_by_day_of_week
  end

  # Most expensive orders
  def most_expensive_orders
    Order.merge(Order.completed)
    .joins(:orders_items)
    .group('orders.id')
    .order('sum_unit_price DESC')
    .sum(:unit_price)
  end
  # Top selling merchants / by revenue
  def top_selling_merchant
    Store.joins(orders: [:orders_items])
    .group('stores.id')
    .order('sum_unit_price DESC')
    .sum(:unit_price)
  end
  # top selling items by revenue
  def top_selling_items
    Item.joins(:orders_items, :orders)
    .merge(Order.completed).group('items.id')
    .order('sum_orders_items_unit_price DESC')
    .sum('orders_items.unit_price')
  end
  # most sold items
  def most_sold_items
    Item.joins(:orders_items, :orders)
    .merge(Order.completed)
    .group('items.id')
    .order('count_items_id DESC')
    .count('items.id')
  end
  # Most active customers by orders
  def most_active_customer
    User.joins(orders: [:orders_items])
    .merge(Order.completed)
    .group('users.id')
    .order('sum_orders_items_unit_price DESC')
    .sum('orders_items.unit_price')
  end
  # Average order price

end
