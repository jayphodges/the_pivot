require 'rails_helper'

describe "User can log out" do
	context "user can click link to log out" do
		scenario "user is logged out and cannot see logout link" do
			user = create(:user)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

			visit items_path

			click_on "Logout"

			expect(current_path).to eq root_path
			expect(page).to have_content("Login")
			expect(page).to_not have_content("Logout")
		end
	end
end