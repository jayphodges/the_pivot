require 'rails_helper'

describe "Visitor can visit retired item page" do
  context "visitor cannot add item to cart" do
    scenario "and should see item is retired" do
      item = create(:item, status: 1)

      expect(item.status).to eq('retired')

      visit item_path(item)

      save_and_open_page

      expect(page).to_not have_content("Add to Cart")
      expect(page).to have_content("Item Retired")
    end
  end

  context "visitor visits items index" do
    scenario "visitor cannot add item to cart" do
      item = create(:item, status: 1)
      item_2 = create(:item, status: 0)

      visit items_path

      within(".index_item_#{item.id}") do
        expect(page).to have_content("Item Retired")
      end

      within(".index_item_#{item_2.id}") do
        expect(page).to have_content("Add to Cart")
      end
    end
  end
end



# -As a user if I visit an item page and that item has been retired
# -Then I should still be able to access the item page
# -And I should not be able to add the item to their cart
# -And I should see in place of the “Add to Cart” button or link - “Item Retired”