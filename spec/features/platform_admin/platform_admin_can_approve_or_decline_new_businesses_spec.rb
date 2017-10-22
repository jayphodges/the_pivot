require 'rails_helper'

describe 'As a platform admin' do
  before(:each) do
  #   pa = create(:user)
  #   role = create(:role, name: 'platform_admin')
  #   pa.roles << role
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(pa)
  end

  it 'admin can approve pending businesses' do
    pa = create(:user)
    store = create(:store, name: 'Test Store1', status: 0)
    role = create(:role, name: 'platform_admin')
    user_roles = UserRole.create(user_id: pa.id, store_id: store.id, role_id: role.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(pa)

    visit '/admin/dashboard'
    click_on('Manage Stores')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Pending')

    click_on('Approve')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Test Store1 has been approved.')
  end

  it 'admin can decline pending businesses' do
    pa = create(:user)
    store = create(:store, name: 'Test Store2', status: 0)
    role = create(:role, name: 'platform_admin')
    user_roles = UserRole.create(user_id: pa.id, store_id: store.id, role_id: role.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(pa)

    visit 'admin/dashboard'
    click_on('Manage Stores')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Pending')

    click_on('Decline')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Test Store2 has been declined.')
  end
end
