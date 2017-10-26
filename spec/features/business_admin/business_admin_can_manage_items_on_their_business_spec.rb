require "rails_helper"

describe "Business Admin can manage items" do
  context "Business Admin visits /dashboard" do
    scenario "admin manages an item for their business" do
      Role.create(name: "registered")
      store = create(:store)
      category = create(:category)
      role  = Role.create(name: "Business Admin")
      user = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth")
      user_role = UserRole.create(user: user, role: role)
      item = Item.create(title: "Wand",
                         description: "Power Tool",
                         price: 12.0,
                         image: "imagestring",
                         category: category,
                         store: store)

    visit store_admin_items_path(store.slug)
    expect(current_path).to eq("/#{store.slug}/admin/items")

    expect(page).to have_css('.item')
    within first('.item') do
      expect(page).to have_link "Edit"
      expect(page).to have_content("Wand")
      click_on "Edit"
    end

    expect(current_path).to eq("/admin/items/#{item.id}/edit")

    fill_in "item[title]", with: "Power Stick"
    click_on "Submit"

    expect(current_path).to eq("/#{store.slug}/admin/items")
    expect(page).to have_css('.item')
    within first('.item') do
      expect(page).to_not have_content("Wand")
      expect(page).to have_content("Power Stick")
    end

    end
  end
end

# When I visit ‘/:store-name/admin/items’
# I should see a list of items
# I should see an edit item button next to each item
# When I click on the edit button
# My path should be ‘/items/:id/edit’
# I should see form fields for all item attributes
# When I click submit
# My path should be ‘/items/:id’
# I should see the new edits to the item
