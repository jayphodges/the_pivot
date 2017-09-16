require 'rails_helper'

describe "Visitor is restricted from admin pages and other user's data" do
  context 'Visitor is restricted from other users info' do
    scenario 'Visitor visits /orders and cannot see other users orders' do
      visit orders_path

      expect(current_path).to eq('/orders')
      expect(page).to have_content("Login")
    end

    scenario 'Visitor tries to checkout' do
      visit orders_path

      expect(page).to_not have_content("Checkout")

      expect(page).to have_content("Login")
    end
  end

  context 'Visitor cannot view admin pages' do
    scenario 'Visitor tries to visit admin dashboard' do
      visit admin_dashboard_path

      expect(current_path).to eq('/admin/dashboard')
      expect(page).to have_content("404")
    end
  end
end