class Admin::AdminController < Admin::BaseController
  before_action :require_admin

  def show
  	binding.pry
    if params[:orders] == 'ordered'
    	@orders = Order.ordered
    elsif params[:orders] == 'cancelled'
    	@orders = Order.cancelled
    elsif params[:orders] == 'paid'
    	@orders = Order.paid
    elsif params[:orders] == 'completed'
    	@orders = Order.completed
    else
    	@orders = Order.all
    end
  end

  private

  def require_admin
    render file: "/public/404" unless current_admin?
  end

end
