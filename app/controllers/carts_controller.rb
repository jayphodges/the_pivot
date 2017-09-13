class CartsController < ApplicationController

  def index

  end

  def create
    redirect_back(fallback_location: items_path)
  end
end
