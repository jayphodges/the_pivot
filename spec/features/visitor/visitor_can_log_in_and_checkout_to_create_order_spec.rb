require 'rails_helper'

describe "Visitor can log in and create order" do
  context "visitor adds items to cart and logs in" do
    scenario "user clicks checkout to create order and can see order" do
      store = create(:store)
      role = Role.create(name: "registered")
      user = user = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth")
      category = create(:category)
      user_role = UserRole.create(user: user, role: role)
      item1 = create(:item, category: category, store: store)
      item2 = create(:item, category: category, store: store)

      visit items_path

      within ".index_item_#{item1.id}" do
        click_on "Add to Cart"
      end

      within ".index_item_#{item2.id}" do
      	click_on "Add to Cart"
      end

      visit cart_path

      click_on "Login or Create Account to Checkout"

      fill_in "session[username]", with: user.username
      fill_in "session[password]", with: user.password
      click_button "Login"

      visit cart_path

      click_on "Checkout"

      expect(current_path).to eq(order_path(Order.all.first))

      expect(page).to have_content("Order was successfully placed")
      expect(page).to have_content("#{Order.last.id}")
      expect(page).to have_content("ordered")
    end
  end
end
