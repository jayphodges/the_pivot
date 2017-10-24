class Api::V1::LoginController < ApplicationController
  before_action :authenticate_api


  def index
    render json: Store.all.first(5)
  end

end
