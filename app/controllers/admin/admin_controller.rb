class Admin::AdminController < Admin::BaseController
  before_action :require_admin

  def show
    if params[:orders] == 'ordered'
    	@orders = Order.ordered.order(:id)
    elsif params[:orders] == 'cancelled'
    	@orders = Order.cancelled.order(:id)
    elsif params[:orders] == 'paid'
    	@orders = Order.paid.order(:id)
    elsif params[:orders] == 'completed'
    	@orders = Order.completed.order(:id)
    else
    	@orders = Order.order(:id)
    end
  end

  private

  def require_admin
    render file: "/public/404" unless current_admin?
  end

end
