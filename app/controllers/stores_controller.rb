class StoresController < ApplicationController

  def show

    @store = Store.find_by(slug: params[:store_name])
  end

  def edit
    @store = Store.find_by(name: params[:store_name])
  end

  def update
    @store = Store.find_by(name: params[:store_name])
    if @store.update(name: params[:store][:name])
      flash[:success] = "#{@store.name} has been updated"

      redirect_to "/#{@store.slug}"
    else
      flash[:message] = "Store has not been updated"
      redirect_to "/#{@store.slug}/edit"
    end
  end

end
