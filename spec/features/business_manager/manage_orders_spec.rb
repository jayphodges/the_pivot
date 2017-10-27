require 'rails_helper'

describe "A Business manager can manage orders" do
  context "Business manager visits /dashboard" do
    scenario "admin manages an order for their business" do
      Role.create(name: "registered")
      store = Store.create(name: "Ricky's Hoop Shop")
      category = create(:category)
      customer = create(:user)
      role  = Role.create(name: "business manager")
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


      visit login_path

      fill_in "session[username]", with: user.username
      fill_in "session[password]", with: user.password
      click_button "Login"

      visit "/#{store.slug}/orders"

      expect(current_path).to eq("/#{store.slug}/orders")

      expect(page).to have_link "Mark as Paid"
      click_on "Mark as Paid"
      expect(current_path).to eq("/#{store.slug}/orders")
    end
  end
end
