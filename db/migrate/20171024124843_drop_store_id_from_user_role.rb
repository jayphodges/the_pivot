class DropStoreIdFromUserRole < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_roles, :store_id
  end
end
