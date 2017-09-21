require 'rails_helper'

describe "Visitor can create an account" do
  context 'visitor clicks on login button' do
    context 'visitor clicks on create account' do
      scenario 'visitor fills in information to create new account' do
        visit root_path

        click_on("Login")

        expect(page).to have_content("Create Account")

        click_on("Create Account")

        fill_in "Username", with: "Joel"
        fill_in "Password", with: "password"
        fill_in "Full Name", with: "Joel Lindow"
        fill_in "Address", with: "1122 Booger Booger Avenue"
        click_on "Submit"

        expect(current_path).to eq("/dashboard")
        expect(page).to have_content("Logged in as Joel")
        expect(page).to have_content("Joel")
        expect(page).to have_content("1122 Booger Booger Avenue")
        expect(page).to have_content("Joel Lindow")
        expect(page).to_not have_content("Login")
        expect(page).to have_content("Logout")
      end
    end
  end
end
