class CategoriesController < ApplicationController

  def show
    @categories = Category.find_by(title: params[:id])
  end
end