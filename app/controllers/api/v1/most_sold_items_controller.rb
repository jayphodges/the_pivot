class Api::V1::MostSoldItemsController < ApplicationController
  before_action :authenticate_api

  def index
    render json: Item.most_sold_items
  end

end
