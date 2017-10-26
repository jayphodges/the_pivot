class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_api

  def orders_by_month
    render json: Order.orders_by_month
  end

  def orders_by_week
    render json: Order.orders_by_day_of_week
  end

  # Most expensive orders = done / orders

  # Top selling merchants / by revenue = done / store

  # top selling items by revenue = done / items

  # most sold items = done / items

  # Most active customers by orders = done / user


end
