class Admin::StoresController < Admin::BaseController
  def index
    @stores = Store.all
  end

  def update
    @store = Store.find(params[:id])
    if params[:approve]
      Store.approve_store(@store)
      flash[:success] = "#{@store.name} has been approved."
    elsif params[:decline]
      Store.decline_store(@store)
      flash[:success] = "#{@store.name} has been declined."
    end
    redirect_to admin_stores_path
  end
end
