class Api::V1::MostSoldItemsController < ApplicationController
  before_action :authenticate_api
  skip_before_action :authorize!

  def index
    render json: Item.most_sold_items.first(5)
  end

end
