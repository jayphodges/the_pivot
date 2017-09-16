require 'rails_helper'

describe "User is restricted from admin pages and other user's data" do
  context 'User is restricted from other users info' do
    scenario 'User visits /orders and cannot see other users orders' do
      user_1 = create(:user, username: 'sam', password: '123')
      user_2 = create(:user, username: 'joel')

      visit login_path

      fill_in "Username", with: "sam"
      fill_in "Password", with: "123"
      within('.login-wrapper') do
        click_on "Login"
      end

      expect(current_path).to eq('/dashboard')
      expect(user_1.role).to eq('default')

      visit orders_path

      expect(current_path).to eq('/orders')
      expect(page).to have_content("All orders for #{user_1.username}")
      expect(page).to_not have_content("All orders for #{user_2.username}")
    end
  end

  context 'User cannot view admin pages' do
    scenario 'User visits admin dashboard' do
      user_1 = create(:user, username: 'sam', password: '123')
      user_2 = create(:user, username: 'joel')

      visit admin_dashboard_path

      expect(current_path).to eq('/admin/dashboard')
      expect(response.status).to eq(404)
    end
  end
end