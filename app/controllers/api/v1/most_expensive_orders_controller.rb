class Api::V1::MostExpensiveOrdersController < ApplicationController
  before_action :authenticate_api

  def index
    render json: Order.most_expensive_orders.first(5)
  end

end
