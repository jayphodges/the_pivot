require 'rails_helper'

describe "Visitor can view items" do
	context "visitor visits /items" do
		scenario "and sees all items" do
			create_list(:item, 5)

			visit items_path

			expect(page).to have_css('.item_card', count: 5)
		end
	end
end