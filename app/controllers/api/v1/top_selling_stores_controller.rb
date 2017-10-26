class Api::V1::TopSellingStoresController < ApplicationController
  before_action :authenticate_api
  skip_before_action :authorize!
  
  def index
    render json: Store.top_selling_stores.first(5)
  end

end
