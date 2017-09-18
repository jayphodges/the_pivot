class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "#{@item.title} has been created."
      redirect_to item_path(@item)
    else
      flash[:message] = "Item has not been created"
      redirect_to new_admin_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "#{@item.title} has been updated."
      redirect_to admin_items_path
    else
      flash[:message] = "Item has not been updated"
      redirect_to edit_admin_item_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :category_id, :image, :status)
  end
end
