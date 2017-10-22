require "rails_helper"

xdescribe "Business Admin can manage other business admins" do
  context "Business Admin visits /dashboard" do
    scenario "business admin manages another business admin" do
      store = create(:store)
      category = create(:category)
      role  = Role.create(name: "Business Admin")
      user = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth")
      user2 = User.create(username: "Freddie Mercury",
                        password: "Bohemian Rhapsody",
                        full_name: "The King of Queen",
                        address: "Radio Gaga")
      user_role = UserRole.create(store: store, user: user, role: role)
      user_role2 = UserRole.create(store: store, user: user2, role: role)
      item = Item.create(title: "Wand",
                         description: "Power Tool",
                         price: 12.0,
                         image: "imagestring",
                         category: category,
                         store: store)

      visit store_path(store.name)
      expect(current_path).to eq("/#{store.name}")

      expect(page).to have_link "Manage Admins"
      click_on "Manage Admins"

      expect(current_path).to eq("/#{store.name}/admins")
      expect(page).to have_css('.admin')
      within last('.admin') do
        expect(page).to have_link "Edit"
        expect(page).to have_content "Freddie Mercury"
        expect(page).to have_content "Radio Gaga"
        click_on "Edit"
      end

      expect(current_path).to eq("/users/#{user2.id}/edit")

      fill_in "user[address]", with: "Under Pressure"
      click_on "Submit Changes"

      expect(current_path).to eq("/#{store.name}/admins")
      expect(page).to have_content("#{user2.name} has been modified")
    end
  end
end
