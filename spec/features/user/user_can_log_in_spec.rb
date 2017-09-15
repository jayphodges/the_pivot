require 'rails_helper'

describe "Registered user can log in" do
	context "user visits '/' and clicks on Login link" do
		context "user can fill in information to log in and see dashboard" do
			user = create(:user)
# -As a registered user
			visit root_path
# -When I visit “/”
			click_on "Login"
# -Then I should see a link for “Login”
# -And when I click “Login”
			expect(current_path).to eq login_path
# -And I should be on the “/login” page
			fill_in "session[username]", with: user.username
			fill_in "session[password]", with: user.password
			click_button "Login"
# -And I should see a place to insert my credentials to login
# -And I fill in my desired credentials
# -And I submit my information
			expect(current_path).to eq dashboard_path
# -Then my current page should be “/dashboard”
			expect(page).to have_content("Logged in as #{user.username}")
# -And I should see a message in the navbar that says “Logged in as SOME_USER”
				expect(page).to have_content(user.username)
        expect(page).to have_content(user.address)
        expect(page).to have_content(user.full_name)
# -And I should see my profile information
        expect(page).to_not have_content("Login")
# -And I should not see a link for “Login”
        expect(page).to have_content("Logout")
# -And I should see a link for “Logout”
		end
	end
end