class Stores::AdminsController < ApplicationController

  def index
    store = Store.find_by(slug: params[:store_name])
    session[:init] = true
    session[:store_id] = store.id
    @admins = store.users
  end

end
