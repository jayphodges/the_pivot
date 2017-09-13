require 'rails_helper'

RSpec.feature "User increases cart quantity of item" do
  scenario "the change is reflected in the cart" do
    category = create(:category)
    item = create(:item, category: category)
    visit '/items'

    click_on "Add to Cart"
    click_on "View Cart"

    within(".item-#{item.id}") do
      expect(page).to have_content("1")
    end

    # expect(page).to have_content("Item Subtotal: $1.00")
    expect(page).to have_content("Total: #{item.price}")

    fill_in "quantity", with: "2"
    click_on "Update"

    expect(current_path).to eq(cart_path)

    within(".item-#{item.id}") do
      expect(page).to have_content("2")
    end
    # expect(page).to have_content("Item Subtotal: $2.00")
    expect(page).to have_content("Total: #{item.price * 2}")
  end
end
