require 'rails_helper'

describe "User can see past orders" do
	context "User visits /orders" do
		scenario "User can see all orders" do
			user = create(:user)
			order1, order2, order3 = create_list(:order, 3, user: user)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
			visit '/orders'

			expect(page).to have_content(order1.id)
			expect(page).to have_content(order2.id)
			expect(page).to have_content(order3.id)
		end
	end
end