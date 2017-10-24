class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_api


  def orders_by_month
    render json: Order.orders_by_month
  end

  def orders_by_week
    render json: Order.orders_by_day_of_week
  end

end
