require 'rails_helper'

describe "Admin changing price does not change order price info" do
  context "user submits order and order has various price data" do
    context "admin updates price of items used in order" do
      scenario "order price info does not change to reflect new price" do
        Role.create(name: "registered")
        store = create(:store)
        category = create(:category)
        role  = Role.create(name: "business admin")
        user = User.create(username: "David Bowie",
                           password: "Goblin King",
                           full_name: "Ziggy Stardust",
                           address: "Labyrinth", phone: '1234567890')
        user_role = UserRole.create(user: user, role: role)

        category = create(:category)
        item1, item2, item3 = create_list(:item, 3, category: category, price: 10.0, store: store)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit items_path

	      within ".index_item_#{item1.id}" do
	        click_on "Add to Cart"
	      end

	      within ".index_item_#{item2.id}" do
	      	click_on "Add to Cart"
	      end

	      within ".index_item_#{item2.id}" do
	      	click_on "Add to Cart"
	      end

	      visit cart_path

	      click_on "Checkout"

	      expect(page).to have_content("$10.00 each")
	      expect(page).to have_content("$10.00")
	      expect(page).to have_content("Total Price: $30.00")

        item1.update(price: 1000.0)

        visit orders_path

        click_on "View Order"

	      expect(page).to have_content("$10.00 each")
	      expect(page).to have_content("$10.00")
	      expect(page).to have_content("Total Price: $30.00")
      end
    end
  end
end
