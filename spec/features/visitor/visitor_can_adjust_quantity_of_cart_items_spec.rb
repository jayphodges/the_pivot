require 'rails_helper'

RSpec.feature "User increases cart quantity of item" do
  scenario "the change is reflected in the cart" do
    category = create(:category)
    item = create(:item, category: category)
    visit '/items'

    click_on "Add to Cart"
    click_on "View Cart"

    within(".item-#{item.id}") do
      expect(page).to have_field("Quantity", with: "1")
    end

    expect(page).to have_content("Item Subtotal: $#{item.formatted_price}")
    expect(page).to have_content("Total: $#{item.formatted_price}")

    fill_in "Quantity", with: "2"
    click_on "Update"

    expect(current_path).to eq(cart_path)

    within(".item-#{item.id}") do
      expect(page).to have_field("Quantity", with: "2")
    end

    expect(page).to have_content("Item Subtotal: $#{(item.formatted_price.to_f * 2).to_s}")
    expect(page).to have_content("Total: $#{(item.formatted_price.to_f * 2).to_s}")
  end

  scenario "User decreases quantity of items in the cart" do
    category = create(:category)
    item = create(:item, category: category)
    item2 = create(:item, category: category)
    visit '/items'

    within(".index_item_#{item.id}") do
      click_on "Add to Cart"
    end

    within(".index_item_#{item2.id}") do
      click_on "Add to Cart"
    end

    click_on "View Cart"

    within(".item-#{item.id}") do
      expect(page).to have_field("Quantity", with: "1")
    end

    within(".item-#{item2.id}") do
      expect(page).to have_field("Quantity", with: "1")
    end

    expect(page).to have_content("Total: $#{(item2.formatted_price.to_f + item.formatted_price.to_f).to_s}")

    within(".item-#{item.id}") do
      fill_in "Quantity", with: "0"
      click_on "Update"
    end

    expect(current_path).to eq cart_path

    within(".item-#{item.id}") do
      expect(page).to have_field("Quantity", with: "0")
      expect(page).to have_content("Item Subtotal: $0.00")
    end

    within(".item-#{item2.id}") do
      expect(page).to have_field("Quantity", with: "1")
      expect(page).to have_content("Item Subtotal: $#{item2.formatted_price}")
    end

    expect(page).to have_content("Total: $#{item2.formatted_price}")
  end

# -As a visitor
# -When I visit “/cart”
# -Then I should see my item with a quantity of 1
# -When I decrease the quantity
# -Then my current page should be ‘/cart’
# -And that item’s quantity should reflect the decrease
# -And the subtotal for that item should decrease
# -And the total for the cart should match that decrease

end
