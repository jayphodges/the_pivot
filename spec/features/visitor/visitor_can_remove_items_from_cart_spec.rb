require 'rails_helper'
describe "Visitor views item index" do
  context "Visitor clicks button to add item" do
    context "Visitor views cart" do
      context "visitor removes item" do
        scenario "Visitor no longer sees item in cart" do
          category = create(:category)
          item = create(:item, category: category)
          visit items_path
          # save_and_open_page
          click_on "Add to Cart"
          click_on "View Cart"
          # save_and_open_page
          expect(page).to have_content(item.title)
          click_on "Remove Item"

          expect(page).to_not have_content(item.title, count: 2)
        end
      end
    end
  end
end
