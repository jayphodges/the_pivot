require 'rails_helper'

describe "User can see individual past order" do
	context "user visits /orders and clicks on order link" do
		scenario "user can see all order information" do
      Role.create(name: "registered")
		  user = create(:user)
      user.roles.create(name: "registered")
			store = create(:store)

		  order = create(:order, user: user, status: 3)

		  category = create(:category)

		  item1 = order.items.create(title: "Cool Item", description: "Descrip",
		  													 price: 35.0, image: "http://lorempixel.com/400/200",
		  													 category: category, store: store)
		  item2 = order.items.create(title: "Cool Item2", description: "Descrip2",
		  													 price: 35.50, image: "http://lorempixel.com/400/200",
		  													 category: category, store: store)
		  item3 = order.items.create(title: "Cool Item3", description: "Descrip3",
		  													 price: 35.99, image: "http://lorempixel.com/400/200",
		  													 category: category, store: store)

	  	OrdersItem.where(item_id: item1.id).update(unit_price: 35.0)
		  OrdersItem.where(item_id: item2.id).update(unit_price: 35.50)
		  OrdersItem.where(item_id: item3.id).update(unit_price: 35.99)

		  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

		  visit '/orders'

		  expect(page).to have_content(order.id)

		  click_on 'View Order'

		  expect(page).to have_content(item1.title)
		  expect(page).to have_content(item2.title)
		  expect(page).to have_content(item3.title)

		  expect(page).to have_content(order.item_quantity(item1))
		  expect(page).to have_content(order.item_subtotal(item1))

		  expect(page).to have_content(order.item_quantity(item2))
		  expect(page).to have_content(order.item_subtotal(item2))

		  expect(page).to have_content(order.item_quantity(item3))
		  expect(page).to have_content(order.item_subtotal(item3))

		  expect(page).to have_selector(:link_or_button, "#{item1.title}")

		  expect(page).to have_content("Order Status: #{order.status}")
			expect(page).to have_content(order.total_order_price)
		  expect(page).to have_content(order.created_at.to_formatted_s(:long_ordinal))
		  expect(page).to have_content("Order completed at")
		  expect(page).to have_content(order.updated_at.to_formatted_s(:long_ordinal))
    end
	end
end
