class Stores::OrdersController < ApplicationController

  def index
    @store = Store.find_by(slug: params[:store_name])
    @orders = @store.orders
  end

  def update
		order = Order.find(params[:id])
		order.cancelled! if params[:status] == 'cancelled'
		order.paid! if params[:status] == 'paid'
		order.completed! if params[:status] == 'complete'
		redirect_back(fallback_location: admin_dashboard_path)
	end
  
end
