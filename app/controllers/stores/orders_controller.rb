class Stores::OrdersController < ApplicationController

  def index
    store = Store.find_by(slug: params[:store_name])
    @orders = store.orders
  end
end
