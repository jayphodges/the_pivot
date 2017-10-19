require 'rails_helper'

describe "Visitor visits multiple stores" do
  context "and can add items from each store" do
    context "and cannot see the checkout button in their cart" do
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
      expect(page).not_to have_content("Checkout")

    end
  end
end


# Log in or create an account before completing checkout.
# When I visit ‘/:store-name1’
# And add an item to my cart
# And I click on my cart
# I should see a link to login or create an account.
# I should not see a checkout button
# When I click on login my path should be ‘/login’
# When I click on create an account my path should be ‘/users/new’
