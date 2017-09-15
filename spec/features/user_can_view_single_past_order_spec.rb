require 'rails_helper'

describe "User can see individual past order" do
	context "user visits /orders and clicks on order link" do
		scenario "user can see all order information" do
		  user = create(:user)
		  order = create(:order, user: user)
		  item1, item2, item3 = create_list(:item, order: order)
		  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

		# -As an authenticated user
		# -When I visit “/orders”
		  visit '/orders'
		# -Then I should see my past order
		  expect(page).to have_content(order.id)
		# -And I should see a link to view that order
		# -And when I click that link
		  click_on 'View'
		# -Then I should see each item that was order with the quantity and line-item subtotals
		  expect(page).to have_content(item1.title)
		  expect(page).to have_content(item2.title)
		  expect(page).to have_content(item3.title)

		  expect(page).to have_content(order.item_quantity(item1))
		  expect(page).to have_content(order.item_subtotal(item1))

		  expect(page).to have_content(order.item_quantity(item2))
		  expect(page).to have_content(order.item_subtotal(item2))

		  expect(page).to have_content(order.item_quantity(item3))
		  expect(page).to have_content(order.item_subtotal(item3))
		# -And I should see links to each item’s show page
		  expect(page).to have_selector(:link_or_button, 'View Item1')
		  expect(page).to have_selector(:link_or_button, 'View Item2')
		  expect(page).to have_selector(:link_or_button, 'View Item3')
		# -And I should see the current status of the order (ordered, paid, cancelled, completed)
		  expect(page).to have_content("Order Status: #{order.status}")
		# -And I should see the total price for the order
			expect(page).to have_content(order.total_order_price)
		# -And I should see the date/time that the order was submitted
		  expect(page).to have_content(order.created_at)
		# -If the order was completed or cancelled
		  expect(page).to have_content("Completed")
		# -Then I should see a timestamp when the action took place
		  expect(page).to have_content(order.updated_at)
    end
	end
end
