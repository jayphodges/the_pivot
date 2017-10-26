class Stores::ItemsController < ApplicationController

  def index
    @store = Store.find_by(slug: params[:store_name].parameterize)
    @items = @store.items
  end

  def new
    @store = Store.find_by(slug: params[:store_name].parameterize)
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "#{@item.title} has been created."
      redirect_to item_path(@item)
    else
      flash[:message] = "Item has not been created"
      redirect_to store_admin_items_path(@item.store.slug)
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :category_id, :image, :status, :store_id)
  end

end
