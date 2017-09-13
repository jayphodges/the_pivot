class CartsController < ApplicationController

  def show

  end

  def create
    redirect_back(fallback_location: items_path)
  end
end
