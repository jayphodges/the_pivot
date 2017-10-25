class PasswordsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user
      ConfirmationSender.send_confirmation_sms(user)
      redirect_to new_password_path(username: user.username)
    else
      redirect_to new_password_reset_path
      flash[:message] = 'Cannot find that user.'
    end
  end

  def update
    user = User.find_by(username: params[:username])
    if user && user.reset_code == params[:reset_code]
      user.update(password: params[:password])
      user.update(reset_code: nil)
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to login_path
    end
  end
end
