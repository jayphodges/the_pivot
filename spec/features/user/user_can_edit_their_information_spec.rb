require 'rails_helper'

describe 'User can edit their information' do
  context 'user can log in' do
    context 'user can visit their edit page' do
      scenario 'user can edit their information' do
        Role.create(name: "registered")
        user = create(:user)
			  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


        visit dashboard_path

        click_on "Edit User"
        expect(current_path).to eq("/users/#{user.id}/edit")

        fill_in "Full Name", with: "Joel Lindow"
        fill_in "Address", with: "1122 Booger Booger Avenue"
        fill_in "Password", with: user.password

        click_on "Submit"

        expect(current_path).to eq(dashboard_path)
      end
    end
  end
end
