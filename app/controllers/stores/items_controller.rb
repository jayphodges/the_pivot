class Stores::ItemsController < ApplicationController
  def index
    store = Store.find_by(name: params[:store_name])
    @items = Item.where(store: store)
  end
end
