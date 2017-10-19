class AddStoreToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :store, foreign_key: true, index: true
  end
end
