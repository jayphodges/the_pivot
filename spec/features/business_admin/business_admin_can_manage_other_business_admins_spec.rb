require "rails_helper"

describe "Business Admin can manage other business admins" do
  context "Business Admin visits /dashboard" do
    scenario "business admin manages another business admin" do
      Role.create(name: "registered")
      store = create(:store)
      category = create(:category)
      role  = Role.create(name: "business admin")
      user = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth")
      user2 = User.create(username: "Freddie Mercury",
                        password: "Bohemian Rhapsody",
                        full_name: "The King of Queen",
                        address: "Radio Gaga")
      user_role = UserRole.create(user: user, role: role)
      user_role2 = UserRole.create(user: user2, role: role)
      item = Item.create(title: "Wand",
                         description: "Power Tool",
                         price: 12.0,
                         image: "imagestring",
                         category: category,
                         store: store)
      store.users << user
      store.users << user2
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/#{store.slug}"
      expect(current_path).to eq("/#{store.slug}")

      expect(page).to have_link "Manage Admins"
      click_on "Manage Admins"

      expect(current_path).to eq("/#{store.slug}/admins")
      expect(page).to have_css('.admin')
      last_css = all('tr.admin').last
      within (last_css) do
        expect(page).to have_link "Edit"
        expect(page).to have_content "Freddie Mercury"
        expect(page).to have_content "Radio Gaga"
        click_on "Edit"
      end

      expect(current_path).to eq("/users/#{user2.id}/edit")
      save_and_open_page

      fill_in "user[address]", with: "Under Pressure"
      click_on "Submit Changes"

      expect(current_path).to eq("/#{store.slug}/admins")

      expect(page).to have_content("#{user2.full_name} has been modified")
    end
  end
end

# Manage other business admins for your store
# When I visit ‘/:store-name’
# I should see a manage business admins button
# When I click on the button
# My path should be ‘/:store-name/admins’
# I should see a list of all current business admins for this store
# I should see a button to edit an individual business admin
# When I click on this button
# I should be on '/users/:id/edit'
# I should be able fill out form fields
# When I click submit,
# I should be back at ‘/:store-name/admins.
# I should see a flash message that :admin was edited
