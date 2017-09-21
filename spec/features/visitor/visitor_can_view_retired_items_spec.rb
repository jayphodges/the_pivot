require 'rails_helper'

describe "Visitor can visit retired item page" do
  context "visitor cannot add item to cart" do
    scenario "and should see item is retired" do
      item = create(:item, status: 1)

      expect(item.status).to eq('retired')

      visit item_path(item)

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
endcs