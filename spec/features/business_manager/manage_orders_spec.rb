require 'rails_helper'
#Manage orders on my business
#When I visit ‘/:store-name/orders’
#I should see a list of orders for the store
#When i click on the edit button next to an order
#I should be taken to /order/:id
#I should see fields to edit the attributes
#When I change the attributes and click submit
#I should see the changes I have made

describe "A Business Admin can manage orders" do
  context "Business Admin visits /dashboard" do
    scenario "admin manages an order for their business" do
      store = Store.create(name: "Ricky's Hoop Shop")
      category = create(:category)
      customer = create(:user)
      role  = Role.create(name: "Business Admin")
      user = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth")
      user_role = UserRole.create(store: store, user: user, role: role)
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
      visit "/#{store.slug}/orders"
      expect(current_path).to eq("/#{store.slug}/orders")

        expect(page).to have_link "Mark as Paid"
        click_on "Mark as Paid"
        expect(current_path).to eq("/#{store.slug}/orders")
        expect(page).to have_link "Mark as Completed"
    end
  end
end
