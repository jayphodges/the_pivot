class OrdersController < ApplicationController
	before_action :require_user
	# before_save 

	def index
	end

	def show
		if Order.find(params[:id]).user_id == current_user.id || current_admin?
			@order = Order.find(params[:id])
			@items = @order.items.distinct
		else
			not_found
		end
	end

	def create
		order = Order.new(user_id: current_user.id)
		order.add_items(@cart)
		if order.save
			order.add_unit_price_to_join(@cart)
			# binding.pry
			session[:cart].clear
			flash[:success] = "Order was successfully placed"
			redirect_to orders_path
		else
			flash[:failure] = "There was an error processing your order"
			redirect_to cart_path
		end
	end

	def update
		order = Order.find(params[:id])
		order.cancelled! if params[:status] == 'cancelled'
		order.paid! if params[:status] == 'paid'
		order.completed! if params[:status] == 'complete'
		redirect_back(fallback_location: admin_dashboard_path)
	end

end