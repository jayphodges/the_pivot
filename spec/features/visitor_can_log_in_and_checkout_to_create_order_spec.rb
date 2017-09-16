require 'rails_helper'

describe "Visitor can log in and create order" do
  context "visitor adds items to cart and logs in" do
    scenario "user clicks checkout to create order and can see order" do
      user = create(:user)
      category = create(:category)
      item1 = create(:item, category: category)
      item2 = create(:item, category: category)

      visit items_path

      within ".index_item_#{item1.id}" do
        click_on "Add to Cart"
      end

      within ".index_item_#{item2.id}" do
      	click_on "Add to Cart"
      end

      visit cart_path

      click_on "Login or Create Account to Checkout"

			fill_in "session[username]", with: user.username
			fill_in "session[password]", with: user.password
			click_button "Login"

			visit cart_path

			click_on "Checkout"

			expect(current_path).to eq(orders_path)

			expect(page).to have_content("Order was successfully placed")
			expect(page).to have_content("Order id: 393829")
			expect(page).to have_content("ordered")
    end
  end
end

# Background: An existing user and a cart with items

# -As a visitor
# -When I add items to my cart
# -And I visit “/cart”
# -And I click “Login or Register to Checkout”
# -Then I should be required to login

# -When I am logged in
# -And I visit my cart
# -And when I click “Checkout”
# -Then the order should be placed
# -And my current page should be “/orders”
# -And I should see a message “Order was successfully placed”
# -And I should see the order I just placed in a table


