class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_cart
  before_action :authorize!

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

  def cart_session?
    true if !session[:cart].nil?
  end

  def not_found
    render file: "/public/404"
  end

  def authenticate_api
    authenticate_or_request_with_http_basic do |username, password|
      user = User.find_by(username: username)
      user && user.authenticate(password)
    end
  end

  def authorize!
    permission = PermissionsService.new(current_user, params[:controller], params[:action])
    not_found unless permission.authorized?
  end

end
