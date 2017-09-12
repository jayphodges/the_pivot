require 'rails_helper'

describe "Visitor can view category path" do
	context "visitor visits /category_name" do
    scenario "and sees all items" do
      create_list(:item, 6, category: "Guitar")
      # As a visitor
      # When I visit “/:CATEGORY_NAME” 
      visit category_path(@category)
      # I see all items assigned to that category
      expect(page).to have_css('.item_card', count: 6)
    end
  end
end