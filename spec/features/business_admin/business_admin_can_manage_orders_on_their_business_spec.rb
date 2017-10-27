require "rails_helper"

describe "A Business Admin can manage orders" do
  context "Business Admin visits /dashboard" do
    scenario "admin manages an order for their business" do
      Role.create(name: "registered")
      store = create(:store)
      category = create(:category)
      customer = create(:user)
      role  = Role.create(name: "business admin")
      user = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth")
      user_role = UserRole.create(user: user, role: role)
      item = Item.create(title: "Wand",
                         description: "Power Tool",
                         price: 12.0,
                         image: "imagestring",
                         category: category,
                         store: store)
      order = Order.create(user: customer,
                           store: store,
                          )
      order.orders_items.create(item: item,
                                unit_price: item.price)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit store_orders_path(store.slug)
      expect(current_path).to eq("/#{store.slug}/orders")

      expect(page).to have_css('.order')
      within first('.order') do
        expect(page).to have_content("#{order.id}")
        expect(page).to have_content("ordered")
      end

      expect(page).to have_content("Mark as Paid")

      click_on "Mark as Paid"

      expect(current_path).to eq("/#{store.slug}/orders")
    
      within first('.order') do
        expect(page).to have_content("#{order.id}")
        expect(page).to have_content("paid")
      end
    end
  end
end

# When I visit ‘/:store-name/orders’
# I should see a list of orders for the store
# When i click on the edit button next to an order
# I should be taken to /order/:id
# I should see fields to edit the attributes
# When I change the attributes and click submit
# I should see the changes I have made
