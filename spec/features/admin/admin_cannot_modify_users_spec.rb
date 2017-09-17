describe 'Admin cannot edit user information' do
  context 'admin can log in' do
    context 'admin can visit their edit page' do
      context 'admin can edit their information' do
        scenario 'admin cannot edit other users information' do
          admin = create(:user, role: 1)

          visit root_path

          click_on "Login"

          expect(current_path).to eq login_path

          fill_in "session[username]", with: admin.username
          fill_in "session[password]", with: admin.password
          click_button "Login"

          expect(current_path).to eq admin_dashboard_path

          click_on "Edit Admin"
          expect(current_path).to eq("/users/#{admin.id}/edit")

          fill_in "Full Name", with: "Joel Lindow"
          fill_in "Address", with: "1122 Booger Booger Avenue"

          click_on "Update"

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content("1122 Booger Booger Avenue")
          expect(page).to have_content("Joel Lindow")

          visit("/users/5/edit")

          fill_in "Full Name", with: "some dude"
          fill_in "Address", with: "some address"

          click_on "Update"

          click_on "Logout"

          user = create(:user, username: 'some_person', password: 'password', id: 5, address: 'something', full_name: 'something else')

          visit root_path

          click_on "Login"

          expect(current_path).to eq login_path

          fill_in "session[username]", with: user.username
          fill_in "session[password]", with: user.password

          within(".login-wrapper") do
            click_on("Login")
          end

          visit("/users/5")

          save_and_open_page

          expect(page).to_not have_content("some dude")
          expect(page).to_not have_content("some address")
        end
      end
    end
  end
end
