require "rails_helper"

xdescribe "A Business Admin can manage orders" do
  context "Business Admin visits /dashboard" do
    scenario "admin manages an order for their business" do
      Role.create(name: "registered")
      store = create(:store)
      category = create(:category)
      customer = create(:user)
      role  = Role.create(name: "Business Admin")
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

      visit store_orders_path(store.name)
      expect(current_path).to eq("/#{store.name}/orders")

      expect(page).to have_css('.order')
      within first('.order') do
        expect(page).to have_link "Manage Order"
        expect(page).to have_content("#{order.id}")
        expect(page).to have_content("ordered")
        click_on "Manage Order"
      end

      expect(current_path).to eq("/orders/#{order.id}")

      expect(page).to have_content("Mark as Paid")

      click_on "Mark as Paid"

      expect(current_path).to eq("/#{store.name}/orders")
      within first('.order') do
        expect(page).to have_link "Manage Order"
        expect(page).to have_content("#{order.id}")
        expect(page).to have_content("paid")
      end
    end
  end
end
