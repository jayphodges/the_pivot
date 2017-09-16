require 'rails_helper'

describe "Visitor views items index" do
  context "Visitor clicks on link to add item to cart" do
    context "Visitor clicks link to visit cart" do
      scenario "Visitor sees item with info and price in cart" do
        category = create(:category)
        item = create(:item, category: category)

        visit items_path
        expect(page).to have_content("Add to Cart")

        click_on "Add to Cart"

        click_on "View Cart"

        expect(current_path).to eq('/cart')
        expect(page).to have_xpath("//img[@src='#{item.image}']")
        expect(page).to have_content(item.title)
        # save_and_open_page
        # expect(page).to have_content(item.description)
        expect(page).to have_content(item.price)
        expect(page).to have_content("Total: $#{item.price}")
      end
    end
  end
end
