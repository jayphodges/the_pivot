require 'rails_helper'

describe 'Admin cannot edit user information' do
  context 'admin can log in' do
    context 'admin can visit their edit page' do
      context 'admin can edit their information' do
        scenario 'admin cannot edit other users information' do
          Role.create(name: "registered")
          store = create(:store)
          store2 = create(:store)
          category = create(:category)
          role  = Role.create(name: "business manager")
          user = User.create(username: "David Bowie",
                             password: "Goblin King",
                             full_name: "Ziggy Stardust",
                             address: "Labyrinth")
          user2 = User.create(username: "Freddie Mercury",
                            password: "Bohemian Rhapsody",
                            full_name: "The King of Queen",
                            address: "Radio Gaga")
          user_role = UserRole.create(user: user, role: role)
          user_role_2 = UserRole.create(user: user2, role: role)

          visit root_path

          click_on "Login"

          expect(current_path).to eq login_path

          fill_in "session[username]", with: user.username
          fill_in "session[password]", with: user.password
          click_button "Login"

          expect(current_path).to eq dashboard_path

          click_on "Edit User"
          expect(page).to have_content("The page you were looking for doesn't exist.")
        end
      end
    end
  end
end
