require 'rails_helper'

describe "Admin can add items" do
  context "Admin visits /admin/items/new" do
    scenario "Admin adds a new item for sale" do
      admin = create(:user, role: 'admin')

      visit login_path

      fill_in "session[username]", with: admin.username
      fill_in "session[password]", with: admin.password
      click_button "Login"

      visit admin_items_new_path

      expect(current_path).to eq('/admin/items/new')

      fill_in "Title", with: "A Product"
      fill_in "Description:", with: "Product description. It's good"
      fill_in "Price", with: 25.99
      select 'Guitars', from: ".category-selector"

      click_on "Submit"
    end
  end
end


  # -As an authenticated Admin:
  # -I can create an item.

  # An item must have a title, description and price.
  # An item must belong to at least one category.
  # The title and description cannot be empty.
  # The title must be unique for all items in the system.
  # The price must be a valid decimal numeric value and greater than zero.
  # The photo is optional. If not present, a stand-in photo is used. (PAPERCLIP)