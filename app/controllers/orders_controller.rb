class OrdersController < ApplicationController

	def index
	end

	def show
		@order = Order.find(params[:id])
		@items = @order.items
	end

end