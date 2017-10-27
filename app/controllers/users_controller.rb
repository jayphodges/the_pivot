class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save && @user.phone.length == 10
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to dashboard_path
    else
      flash[:message] = "You have made a mistake."
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
    if session[:store_id] != nil
     @store = Store.find(session[:store_id])
    end
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if session[:store_id] != nil
      store = Store.find(session[:store_id])
    end
    if @user.update(user_params)
      flash[:success] = "#{@user.full_name} has been modified"
      if session[:store_id] != nil
        redirect_to store_admins_path(store.slug)
      else
        redirect_to dashboard_path
      end
    else
      flash[:message] = "That change was not successful"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :full_name, :address, :phone)
  end
end
