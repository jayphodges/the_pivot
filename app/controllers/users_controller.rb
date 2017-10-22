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
    if !current_user.nil?
      @user = current_user
    else
      not_found
    end
  end

  def edit
    user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :full_name, :address)
  end
end
