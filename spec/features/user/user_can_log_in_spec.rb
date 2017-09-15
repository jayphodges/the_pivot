require 'rails_helper'

describe "Registered user can log in" do
	context "user visits '/' and clicks on Login link" do
		scenario "user can fill in information to log in and see dashboard" do
			user = create(:user)

			visit root_path

			click_on "Login"

			expect(current_path).to eq login_path

			fill_in "session[username]", with: user.username
			fill_in "session[password]", with: user.password
			click_button "Login"

			expect(current_path).to eq dashboard_path

			expect(page).to have_content("Logged in as #{user.username}")

			expect(page).to have_content(user.username)
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.full_name)

      expect(page).to_not have_content("Login")

      expect(page).to have_content("Logout")
		end
	end
end