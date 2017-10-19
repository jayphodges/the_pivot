class AddStoreToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :store, foreign_key: true, index: true
  end
end
