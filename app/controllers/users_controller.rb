class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :full_name, :address)
  end
end
