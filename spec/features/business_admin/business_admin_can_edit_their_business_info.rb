require "rails_helper"

describe "Business Admin can manage their business information" do
  context "Business Admin visits /dashboard" do
    scenario "business admin can manage their business' information" do
      store = create(:store)
      name = store.name
      category = create(:category)
      role  = Role.create(name: "Business Admin")
      user = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth")
      user_role = UserRole.create(store: store, user: user, role: role)
      item = Item.create(title: "Wand",
                         description: "Power Tool",
                         price: 12.0,
                         image: "imagestring",
                         category: category,
                         store: store)
      visit store_path(store.name)
      expect(current_path).to eq("/#{store.name}")
      expect(page).to have_content("Edit Business")

      click_on "Edit Business"

      expect(current_path).to eq("/stores/#{store.id}/edit")

      fill_in "store[name]", with: "Test Name"
      click_on "Submit Changes"

      expect(current_path).to eq("/test-name")
      expect(current_path).to_not eq("/#{name}")
    end
  end
end

# Update my business information
# When I visit ‘/:store-name’
# I should see an edit business information button
# When I click on the button
# My path should be ‘/stores/:id/edit’
# I should see different form fields
# When I fill out the form fields and click submit
# I should be at ‘/:store-name’
# I should see the new business information
