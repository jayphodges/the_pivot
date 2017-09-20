class CartsController < ApplicationController

  def show
    if cart_session?
      @items = Item.where(id: session[:cart].keys)
    else
      @items = nil
    end
  end

  def create
    id = params["item_id"].to_s
    @item = Item.find_by(id: id)
    session[:cart] ||= Hash.new(0)
    session[:cart][id] = (session[:cart][id] || 0) + 1
    redirect_back(fallback_location: items_path)
  end

  def update
    if params[:Quantity] <= '-1'
      flash[:failure] = "Cannot enter negative number!"
      redirect_to cart_path
    elsif params[:Quantity] == '0'
      item = Item.find(params[:item_id])
      session[:cart].delete(item.id.to_s)
      redirect_to cart_path
    else
      item = Item.find(params[:item_id])
      @cart.update_item(item.id, params[:Quantity])
      redirect_to cart_path
    end
  end

  def destroy
    item = Item.find(params[:id])
    session[:cart].delete(params[:id].to_s)
    flash[:success] = "Successfully removed #{item.title} from your cart"
    redirect_to cart_path
  end
end
