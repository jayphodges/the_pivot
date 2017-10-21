class AddSlugToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :slug, :string
  end
end
