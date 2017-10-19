require 'rails_helper'

describe "Visitor visits multiple stores" do
  context "and can add items from each store" do
    context "and view those items in their cart" do
      store1, store2 = create_list(:store, 2)
      create_list(:item, 3, store: store1)
      create(:item, store: store2)

      visit stores_path

      click_on "#{store1.title}"

      # visit "/#{store1.title}"

      within ".index_item_#{store1.items.first.id}" do
        click_on "Add to Cart"
      end

      within ".index_item_#{store1.items.second.id}" do
        click_on "Add to Cart"
      end

      visit stores_path

      click_on "#{store2.title}"

      # visit "/#{store2.title}"

      within ".index_item_#{store2.items.first.id}" do
        click_on "Add to Cart"
      end

      visit cart_path

      expect(current_path).to eq('/cart')
      expect(page).not_to have_content(store1.items.last.title)
      expect(page).to have_content(store1.items.first.title)
      expect(page).to have_content(store1.items.second.title)
      expect(page).to have_content(store2.items.first.title)
    end
  end
end

# Add items from multiple businesses into a single cart.
# When I visit ‘/:store-name1’
# And add an item to my cart
# And when I visit ‘/:store-name2’
# And add an item to my cart
# And I click on my cart
# And my path should be ‘/cart’
# I expect to have two items in my cart
