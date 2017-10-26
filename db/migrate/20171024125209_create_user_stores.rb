class CreateUserStores < ActiveRecord::Migration[5.1]
  def change
    create_table :user_stores do |t|
      t.references :users, foreign_key: true
      t.references :stores, foreign_key: true

      t.timestamps
    end
  end
end
