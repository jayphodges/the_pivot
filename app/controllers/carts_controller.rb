class CartsController < ApplicationController

  def show
    @items = Item.find_by(id: :item_id)
  end

  def create
    redirect_back(fallback_location: items_path)
  end
end
