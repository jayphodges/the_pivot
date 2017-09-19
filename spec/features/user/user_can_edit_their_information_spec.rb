require 'rails_helper'

describe 'User can edit their information' do
  context 'user can log in' do
    context 'user can visit their edit page' do
      scenario 'user can edit their information' do
        user = create(:user)

        visit root_path

        click_on "Login"

        expect(current_path).to eq login_path

        fill_in "session[username]", with: user.username
        fill_in "session[password]", with: user.password
        click_button "Login"

        expect(current_path).to eq dashboard_path

        click_on "Edit User"
        expect(current_path).to eq("/users/#{user.id}/edit")

        fill_in "Full Name", with: "Joel Lindow"
        fill_in "Address", with: "1122 Booger Booger Avenue"

        click_on "Submit"

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("1122 Booger Booger Avenue")
        expect(page).to have_content("Joel Lindow")
      end
    end
  end
end
