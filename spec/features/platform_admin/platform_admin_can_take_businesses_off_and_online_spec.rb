# Take a business offline / online
# When I visit ‘/admin/businesses’
# I should see a list of all businesses
# With an offline button for active businesses
# When I click on the offline button
# I should see a message that the business is offline
# No one but PAs can see the business
# When I visit ‘/admin/businesses’
# I should see an option to turn the business online
# Everyone can then see the business
# Perform any functionality restricted to business admins

require 'rails_helper'

describe 'As a platform admin' do
  it 'admin can take a store offline' do
    pa = create(:user)
    store = create(:store, name: 'Test Store1', status: 1)
    role = create(:role, name: 'platform_admin')
    user_roles = UserRole.create(user_id: pa.id, store_id: store.id, role_id: role.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(pa)

    visit '/admin/dashboard'
    click_on('Manage Stores')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Online')

    click_on('Take Offline')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Test Store1 has been taken offline.')
  end

  it 'admin can put a store online' do
    pa = create(:user)
    store = create(:store, name: 'Test Store2', status: 2)
    role = create(:role, name: 'platform_admin')
    user_roles = UserRole.create(user_id: pa.id, store_id: store.id, role_id: role.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(pa)

    visit 'admin/dashboard'
    click_on('Manage Stores')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Offline')

    click_on('Put Online')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Test Store2 has been put online.')
  end
end
