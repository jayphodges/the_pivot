require 'rails_helper'

describe "Visitor views /stores" do
  context "and can view a list of stores" do
    context "and view that store's items" do
      store1, store2 = create_list(:store, 2)
      create_list(:item, 3, store: store1)
      create(:item, store: store2)

      visit stores_path

      expect(page).to have_content(store1.name)
      expect(page).to have_content(store2.name)

      click_on "#{store1.name}"

      expect(current_path).to eq("#{store1.name}")

      expect(current_path).to eq('/cart')
      expect(page).not_to have_content(store2.items.first.title)
      expect(page).to have_content(store1.items.first.title)
      expect(page).to have_content(store1.items.last.title)
    end
  end
end


# Visit different businesses.
# When I visit ‘/stores’
# I see a list of stores
# When I click on one of the stores
# I am directed to the store’s root page
# I see only that store’s items
# And my path should be ‘/:store-name’
