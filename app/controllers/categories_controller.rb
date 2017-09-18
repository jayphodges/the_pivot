class CategoriesController < ApplicationController

  def show
    if Category.find_by(title: params[:id])
      @category = Category.find_by(title: params[:id])
    else
      not_found
    end
  end
end