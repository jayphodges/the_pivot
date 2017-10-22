require 'rails_helper'

xdescribe "Admin can see dashboard" do
  context "User visits /admin/dashboard" do
    scenario "User can not see Admin Dashboard and gets a 404" do
      user = create(:user)

      visit login_path

      fill_in "session[username]", with: user.username
      fill_in "session[password]", with: user.password
      click_button "Login"

      visit admin_dashboard_path

      expect(page).to have_content(404)
    end

    scenario "Admin can see dashboard and sees heading" do
      admin = create(:user, role: 1)

      visit login_path

      fill_in "session[username]", with: admin.username
      fill_in "session[password]", with: admin.password
      click_button "Login"

      visit admin_dashboard_path

      expect(page).to have_content("Admin Dashboard")
    end
  end
end
