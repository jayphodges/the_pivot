class AddUnitPriceToOrdersItems < ActiveRecord::Migration[5.1]
  def change
    add_column :orders_items, :unit_price, :float
  end
end
