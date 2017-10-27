require 'rails_helper'

describe "Admin visits site" do
  scenario "Admin can log in" do
    Role.create(name: "registered")
    store = create(:store)
    category = create(:category)
    role  = Role.create(name: "business admin")
    user = User.create(username: "David Bowie",
                       password: "Goblin King",
                       full_name: "Ziggy Stardust",
                       address: "Labyrinth")
    user_role = UserRole.create(user: user, role: role)

    visit login_path

    fill_in "session[username]", with: user.username
    fill_in "session[password]", with: user.password
    click_button "Login"

    expect(current_path).to eq(dashboard_path)
  end
end
