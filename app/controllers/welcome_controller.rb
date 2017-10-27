class WelcomeController < ApplicationController

  def index
    @stores = Store.all
  end
  
end
