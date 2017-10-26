class Api::V1::MostActiveCustomerController < ApplicationController
  before_action :authenticate_api

  def most_active_customer
    User.joins(orders: [:orders_items])
    .merge(Order.completed)
    .group('users.id')
    .order('sum_orders_items_unit_price DESC')
    .sum('orders_items.unit_price')
  end

end
