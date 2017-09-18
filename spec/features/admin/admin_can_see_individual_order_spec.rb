require 'rails_helper'

describe "Admin can view individual order" do
  context "admin visits individual order page" do
    context "and admin can see order information" do
      scenario "and also see that orders items information" do
        category = create(:category)

	      user = create(:user)

	      order1 = create(:order, user: user)

	      admin = create(:user, role: 1)

			  item1 = order1.items.create(title: "Cool Item", description: "Descrip",
			  													 price: 35.0, image: "http://lorempixel.com/400/200",
			  													 category: category)
			  item2 = order1.items.create(title: "Cool Item2", description: "Descrip2",
			  													 price: 35.50, image: "http://lorempixel.com/400/200",
			  													 category: category)
			  item3 = order1.items.create(title: "Cool Item3", description: "Descrip3",
			  													 price: 35.99, image: "http://lorempixel.com/400/200",
			  													 category: category)

	      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
# -As an authenticated Admin, when I visit an individual order page
	      visit order_path(order1)

	      save_and_open_page
# -Then I can see the order’s date and time.
	      expect(page).to have_content("Order #{order1.id}")
	      expect(page).to have_content("Order Submitted: #{order1.created_at.to_formatted_s(:long_ordinal)}")
	      expect(page).to have_content("Order #{order1.status} at: #{order1.updated_at.to_formatted_s(:long_ordinal)}")
# -And I can see the purchaser’s full name and address.
        expect(page).to have_content("Customer Name: #{user.full_name}")
        expect(page).to have_content("Mailing Address: #{user.address}")
# -And I can see, for each item on the order:
# The item’s name, which is linked to the item page.
        expect(page).to have_selector(:link_or_button, "item1.title")
# Quantity in this order.
        expect(page).to have_content(order1.item_quantity(item1))
# Price
        expect(page).to have_content("$35.00 Each")
# Line item subtotal. And I can see the total for the order. And I can see the status for the order.
        expect(page).to have_content("Subtotal: $35.50")
        expect(page).to have_content("Total Price: $106.49")
      end
    end
  end
end
