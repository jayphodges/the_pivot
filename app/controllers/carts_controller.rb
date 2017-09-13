class CartsController < ApplicationController

  def index

  end

  def create
    byebug
    redirect_back(fallback: items_path)
  end
end
