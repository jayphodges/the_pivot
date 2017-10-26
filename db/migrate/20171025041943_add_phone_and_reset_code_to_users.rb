class AddPhoneAndResetCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :reset_code, :string
  end
end
