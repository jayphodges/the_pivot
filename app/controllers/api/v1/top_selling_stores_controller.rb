class Api::V1::TopSellingStoresController < ApplicationController
  before_action :authenticate_api

  def index
    render json: Store.top_selling_stores
  end

end
