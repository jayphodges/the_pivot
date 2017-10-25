class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_api

  def orders_by_month
    render json: Order.orders_by_month
  end

  def orders_by_week
    render json: Order.orders_by_day_of_week
  end

  # Average Order price
  def most_expensive_orders
    Order.merge(Order.completed).joins(:orders_items).group('orders.id').order('sum_unit_price DESC').sum(:unit_price)
  end
  # Top selling merchants / by revenue
  def top_selling_merchant
    Store
  end
  # top selling items

  # top item by revenue

  # Most active customers

  #

end
