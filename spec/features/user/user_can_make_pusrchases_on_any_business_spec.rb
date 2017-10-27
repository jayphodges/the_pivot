require 'rails_helper'

describe "Registered User can make purchases on any business" do
  scenario "user makes a purchase from two different stores" do
    Role.create(name: "registered")
    store = create(:store)
    store_2 = create(:store)
    category = create(:category)
    role  = Role.create(name: "Registered User")
    user = User.create(username: "David Bowie",
                       password: "Goblin King",
                       full_name: "Ziggy Stardust",
                       address: "Labyrinth", phone: '1234567890')

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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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
