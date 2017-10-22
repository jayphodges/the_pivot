class Admin::StoresController < Admin::BaseController
  def index
    @stores = Store.all
  end

  def update
    @store = Store.find(params[:id])
    if params[:approve]
      Store.put_store_online(@store)
      flash[:success] = "#{@store.name} has been approved."
    elsif params[:decline]
      Store.decline_store(@store)
      flash[:success] = "#{@store.name} has been declined."
    elsif params[:take_offline]
      Store.take_store_offline(@store)
      flash[:success] = "#{@store.name} has been taken offline."
    elsif params[:put_online]
      Store.put_store_online(@store)
      flash[:success] = "#{@store.name} has been put online."
    end
    redirect_to admin_stores_path
  end
end
