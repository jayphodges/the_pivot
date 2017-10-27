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
  scenario "I can edit items for my store" do
      store = create(:store)
      Role.create(name: "registered")
      user = create(:user)
      role  = Role.create(name: "business manager")
      user_role = UserRole.create(user: user, role: role)

      visit login_path

      fill_in "session[username]", with: user.username
      fill_in "session[password]", with: user.password
      click_button "Login"


    #store setup
    store = Store.create(name: "Ricky's Hoop Shop")
    category = create(:category, title: "Guitars")
		item1 = store.items.create!(title: "Cool Item1", description: "Descrip1",
                                price: 35.50, image: "http://lorempixel.com/400/200", category_id: category.id)


    visit "/ricky-s-hoop-shop/admin/items"

    expect(page).to have_content("Cool Item1")

    click_on ("Edit")

    expect(current_path).to eq("/admin/items/#{item1.id}/edit")

    fill_in "item-title", with: "whatever"
    fill_in "item-description", with: "something else"
    attach_file("item-image", './app/assets/images/logo-header.png')

    click_on ("Submit")

    expect(current_path).to eq("/#{store.slug}/admin/items")

    expect(page).to have_content("whatever")
    expect(page).to have_content("something else")


  end
end
