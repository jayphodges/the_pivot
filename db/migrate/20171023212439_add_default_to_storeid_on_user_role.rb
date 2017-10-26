class AddDefaultToStoreidOnUserRole < ActiveRecord::Migration[5.1]
  def change
    change_column :user_roles, :store_id, :integer, default: 0
  end
end
