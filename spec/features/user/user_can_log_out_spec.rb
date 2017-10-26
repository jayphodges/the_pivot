require 'rails_helper'

describe "User can log out" do
	context "user can click link to log out" do
		scenario "user is logged out and cannot see logout link" do
      Role.create(name: "registered")
			user = create(:user)

			visit root_path

			click_on "Login"

			expect(current_path).to eq login_path

			fill_in "session[username]", with: user.username
			fill_in "session[password]", with: user.password
			click_button "Login"

			click_on "Logout"

			expect(page).to have_content("Login")
			expect(page).to_not have_content("Logout")
		end
	end
end
