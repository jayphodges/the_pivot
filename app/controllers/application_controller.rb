class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_cart

  def current_admin?
    current_user && current_user.admin?
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def require_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
