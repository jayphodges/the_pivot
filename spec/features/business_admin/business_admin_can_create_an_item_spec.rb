require 'rails_helper'

describe "Business Admin can add items" do
  context "Business Admin visits /admin/items/new" do
    scenario "Business Admin adds a new item for sale" do
      category = create(:category, title: "Guitars")
      store = create(:store)
      role = Role.create(name: "Business Admin")
      user = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth")
      user_role = UserRole.create(store: store, user: user, role: role)

      visit login_path

      fill_in "session[username]", with: user.username
      fill_in "session[password]", with: user.password
      click_button "Login"

      visit "/#{store.slug}/admins/items/new"

      expect(current_path).to eq('/name-1/admins/items/new')

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
