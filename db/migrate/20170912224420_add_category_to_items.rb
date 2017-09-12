class AddCategoryToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :category, foreign_key: true, index: true
  end
end
