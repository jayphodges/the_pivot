require 'rails_helper'

describe "Registered User can make purchases on any business" do
  scenario "user makes a purchase from two different stores" do
    store = create(:store)
    store_2 = create(:store)
    category = create(:category)
    role  = Role.create(name: "Registered User")
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
    item_2 = Item.create(title: "Sword",
                       description: "Hygene",
                       price: 4.0,
                       image: "imagestring",
                       category: category,
                       store: store_2)

    visit login_path

     fill_in "session[username]", with: user.username
     fill_in "session[password]", with: user.password
     click_button "Login"

    expect(Order.all.count).to eq(0)
    visit "/#{store.slug}"
    expect(current_path).to eq("/#{store.slug}")

    within first('.item') do
      click_on "Add to Cart"
    end

    visit "/#{store_2.slug}"

    within first('.item') do
      click_on "Add to Cart"
    end

    click_on "View Cart"

    expect(current_path).to eq("/cart")

    click_on "Checkout"

    expect(current_path).to eq("/orders/#{Order.first.id}")
    expect(page).to have_css('.order')
    within first('.order') do
      expect(page).to have_content("Wand")
      expect(page).to have_content("Sword")
    end

    expect(Order.all.count).to eq(1)
  end
end

# When I visit ‘/:store-name1’
# And add an item to my cart
# And when I visit ‘/:store-name2’
# And add an item to my cart
# And I click on my cart
# My path should be ‘/cart’
# I should see a checkout button
# When I click on checkout
# I should be on ‘users/:id/orders’
# I should see my last order
