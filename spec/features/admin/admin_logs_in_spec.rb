require 'rails_helper'

xdescribe "Admin visits site" do
  scenario "Admin can log in" do
    admin = create(:user, role: 1)

    visit login_path

    fill_in "session[username]", with: admin.username
    fill_in "session[password]", with: admin.password
    click_button "Login"

    expect(current_path).to eq(admin_dashboard_path)
  end
end
