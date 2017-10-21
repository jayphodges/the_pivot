require 'rails_helper'

#As a business manager I should be able to:
#Manage items on my business
#When I visit ‘/:store-name/admin/items’
#I should see a list of items
#I should see an edit item button next to each item
#When I click on the edit button
#My path should be ‘/items/:id/edit’
#I should see form fields for all item attributes
#When I click submit
#My path should be ‘/items/:id’
#I should see the new edits to the item


describe "As a Business Manager" do
  scenario "I can edit items for my stores" do

    #store setup

    visit "/rickys-hoop-shop/admin/items'"

    expect(page).to have_content("Big Hoop")
    expect(page).to have_content("Small Hoop")

    first(:item).click

    expect(current_path).to eq("/items/#{item1.id}/edit")

    #edit the item
    #
    click_on "Submit"

    expect(page).to have_content("Edited item")

  end
end
