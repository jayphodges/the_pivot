require 'rails_helper'

describe "Admin can see dashboard" do
  context "User visits /admin/dashboard" do
    scenario "User can not see Admin Dashboard and gets a 404" do
      category = create(:category)
      role  = Role.create(name: "registered")
      admin = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth", phone: '1234567890')

      user_role = UserRole.create(user: admin, role: role)

      visit login_path

      fill_in "session[username]", with: admin.username
      fill_in "session[password]", with: admin.password
      click_button "Login"

      visit admin_dashboard_path

      expect(page).to have_content(404)
    end

    scenario "Admin can see dashboard and sees heading" do
      Role.create(name: "registered")
      role  = Role.create(name: "platform admin")
      admin = User.create(username: "David Bowie",
                         password: "Goblin King",
                         full_name: "Ziggy Stardust",
                         address: "Labyrinth", phone: '1234567890')

      user_role = UserRole.create(user: admin, role: role)

      visit login_path

      fill_in "session[username]", with: admin.username
      fill_in "session[password]", with: admin.password
      click_button "Login"

      visit admin_dashboard_path

      expect(page).to have_content("Admin Dashboard")
    end
  end
end
