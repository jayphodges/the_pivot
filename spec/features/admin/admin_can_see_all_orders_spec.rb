require 'rails_helper'

describe "Admin can see and manipulate all orders" do
  context "admin visits dashboard and can see all orders" do
    scenario "and can filter orders and transition status" do
# -As an Admin
      category = create(:category)

      user = create(:user)

      order1, order2, order3, order4, order5 = create_list(:order, 5, user: user)
      order1.cancelled!
      order2.paid!
      order3.paid!
      order4.completed!

      admin = create(:user, role: 1)

		  item1 = order1.items.create(title: "Cool Item", description: "Descrip",
		  													 price: 35.0, image: "http://lorempixel.com/400/200",
		  													 category: category)
		  item2 = order2.items.create(title: "Cool Item2", description: "Descrip2",
		  													 price: 35.50, image: "http://lorempixel.com/400/200",
		  													 category: category)
		  item3 = order3.items.create(title: "Cool Item3", description: "Descrip3",
		  													 price: 35.99, image: "http://lorempixel.com/400/200",
		  													 category: category)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
# -When I visit the dashboard
      visit admin_dashboard_path
# -Then I can see a listing of all orders
      expect(page).to have_content(order1.id)
      expect(page).to have_content(order1.created_at)
      expect(page).to have_content(order1.updated_at)
      expect(page).to have_content(order1.status)
      expect(page).to have_content(order2.id)
      expect(page).to have_content(order2.created_at)
      expect(page).to have_content(order2.updated_at)
      expect(page).to have_content(order2.status)
      expect(page).to have_content(order3.id)
      expect(page).to have_content(order3.created_at)
      expect(page).to have_content(order3.updated_at)
      expect(page).to have_content(order3.status)
# -And I can see the total number of orders for each status (“Ordered”, “Paid”, “Cancelled”, “Completed”)
      expect(page).to have_content("Paid Orders: 2")
      expect(page).to have_content("Cancelled Orders: 1")
      expect(page).to have_content("Ordered Orders: 1")
      expect(page).to have_content("Completed Orders: 1")
# -And I can see a link for each individual order
      expect(page).to have_content("View Order", count: 5)
# -And I can filter orders to display by each status type (“Ordered”, “Paid”, “Cancelled”, “Completed”)
      expect(page).to have_selector(:link_or_button, "All Orders")
      expect(page).to have_selector(:link_or_button, "Ordered Orders")
      expect(page).to have_selector(:link_or_button, "Paid Orders")
      expect(page).to have_selector(:link_or_button, "Cancelled Orders")
      expect(page).to have_selector(:link_or_button, "Completed Orders")
# -And I have links to transition between statuses
      click_on "Ordered Orders"

      expect(page).to_not have_content("Id: 2")
      expect(page).to_not have_content("Id: 3")
      expect(page).to_not have_content("Id: 1")
      expect(page).to_not have_content("Id: 4")
      expect(page).to have_content("Id: 5")

      click_on "Paid Orders"

      expect(page).to have_content("Id: 2")
      expect(page).to have_content("Id: 3")
      expect(page).to_not have_content("Id: 1")
      expect(page).to_not have_content("Id: 4")
      expect(page).to_not have_content("Id: 5")

      click_on "Cancelled Orders"

      expect(page).to have_content("Id: 1")
      expect(page).to_not have_content("Id: 2")
      expect(page).to_not have_content("Id: 3")
      expect(page).to_not have_content("Id: 4")
      expect(page).to_not have_content("Id: 5")

      click_on "Completed Orders"

      expect(page).to_not have_content("Id: 1")
      expect(page).to_not have_content("Id: 2")
      expect(page).to_not have_content("Id: 3")
      expect(page).to have_content("Id: 4")
      expect(page).to_not have_content("Id: 5")
# -I can click on “cancel” on individual orders which are “paid” or “ordered”
      click_on "All Orders"

      expect(page).to have_content("cancelled", count: 1)

      within(".admin_index_order2") do
        click_on "Cancel"
      end

      expect(page).to have_content("cancelled", count: 2)
# -I can click on “mark as paid” on orders that are “ordered”
      expect(page).to have_content("ordered", count: 1)

      within(".admin_index_order5") do
        click_on "Mark as Paid"
      end

      expect(page).to have_content("ordered", count: 2)
# -I can click on “mark as completed” on orders that are “paid”
      expect(page).to have_content("completed", count: 1)

      within(".admin_index_order3") do
        click_on "Mark as Completed"
      end

      expect(page).to have_content("completed", count: 2)
    end
  end
end
