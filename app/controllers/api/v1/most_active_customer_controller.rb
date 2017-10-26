class Api::V1::MostActiveCustomerController < ApplicationController
  before_action :authenticate_api

  def index
    render json: User.most_active_customer.first(5)
  end

end
