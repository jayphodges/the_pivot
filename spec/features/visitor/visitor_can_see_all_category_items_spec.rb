require 'rails_helper'

describe "Visitor can view category path" do
	context "visitor visits /category_name" do
    scenario "and sees all items" do
      category = create(:category, title: "Guitar")
      create_list(:item, 6, category: category)
 
      visit category_path(category)

      expect(page).to have_css('.item_card', count: 6)
    end
  end
end