class ChangeUserStores < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_stores, :stores_id, :store_id
    rename_column :user_stores, :users_id, :user_id
  end
end
