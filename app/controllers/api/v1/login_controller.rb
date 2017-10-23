class Api::V1::CustomersController < ApplicationController

  def login_user(params)
    if params[:authentication]
      @user = User.find_by(auth_token: params[:authentication])
      if @user.nil?
        render json: err('login user by token failed', ERR_USER_NOT_FOUND), status: :not_found
        event('login_user_by_auth_failed', 'token', params[:authentication])
        return
      else
        render status: :ok, json: @user
        return
      end
    else
      user = user.find_by(username: params[:username])
      if user.nil?
        event('login_user_failed_not_found', 'user_username', params[:username])
        render json: err("login user not found #{params[:username]}", ERR_USER_NOT_FOUND), status: :not_found
        return
      end
      if user.access_locked?
        event('login_user_blocked', 'user_id', user.id)
        render json: err("login user account is locked : #{user.id}", ERR_USER_LOCKED), status: :unauthorized
        return
      end
      unless user.try(:valid_password?, params[:password])
        event("login_user_password_does_not_match #{user.id}", 'user_id',  user.id)
        render json: err('login user password does not match', ERR_PASSWORD_NOT_MATCH), status: :unauthorized
        return
      end
      event('login_user_succeeded', 'user_id', user.id)
      @user= user
      if @user.save
        response.headers['authentication'] = @user.auth_token
        render status: :ok, json: @user
        return
      else
        render json: @user.errors, status: :unprocessable_entity
        return
      end
    end
  end

end
