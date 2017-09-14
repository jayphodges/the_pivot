class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.float :price
      t.string :image

      t.timestamps
    end
  end
end
