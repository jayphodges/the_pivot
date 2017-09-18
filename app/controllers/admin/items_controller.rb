class Admin::ItemsController < Admin::BaseController
  def index
    
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
      flash[:message] = "User Profile not created"
      redirect_to new_user_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :category_id, :image)
  end
end
