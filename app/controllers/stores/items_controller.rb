class Stores::ItemsController < ApplicationController

  def index
    @store = Store.find_by(slug: params[:store_name].parameterize)
    @items = @store.items
  end
end
