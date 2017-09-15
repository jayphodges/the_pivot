require 'rails_helper'

describe "User can see past orders" do
	context "User visits /orders" do
		scenario "User can see all orders" do
			user = create(:user)
			user.orders.create_list(:order, 3)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

			visit '/orders'

			expect(page).to have_content(order.first.id)
			expect(page).to have_content(order.last.id)
			# expect(page).to have_content("Order", count: 4)
		end
	end
end

#id
#created_at
#updated_at
