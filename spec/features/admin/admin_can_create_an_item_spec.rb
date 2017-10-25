require 'rails_helper'

describe "Admin can add items" do
  context "Admin visits /admin/items/new" do
    scenario "Admin adds a new item for sale" do
      admin = create(:user)
      category = create(:category, title: "Guitars")

      visit login_path

      fill_in "session[username]", with: admin.username
      fill_in "session[password]", with: admin.password
      click_button "Login"

      visit new_admin_item_path

      expect(current_path).to eq('/admin/items/new')

      fill_in "item-title", with: "A Product"
      fill_in "item-description", with: "Product description. It's good"
      fill_in "item-price", with: 25.99
      select 'Guitars', from: "item_category_id"
      attach_file("item-image", './app/assets/images/logo-header.png')

      click_on "Submit"

      expect(page).to have_content("A Product has been created.")

      visit items_path

      expect(page).to have_content("A Product")
    end
  end
end
