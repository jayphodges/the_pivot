require 'rails_helper'

describe 'As a platform admin' do
  it 'admin can approve pending stores' do
    Role.create(name: "registered")
    pa = create(:user)
    store = create(:store, name: 'Test Store1', status: 0)
    role = create(:role, name: 'platform admin')
    user_roles = UserRole.create(user_id: pa.id, role_id: role.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(pa)

    visit '/admin/dashboard'
    click_on('Manage Stores')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Pending')

    click_on('Approve')

    expect(current_path).to eq('/admin/stores')
    expect(page).to have_content('Test Store1 has been approved.')
  end

  it 'admin can decline pending stores' do
    Role.create(name: "registered")
    pa = create(:user)
    store = create(:store, name: 'Test Store2', status: 0)
    role = create(:role, name: 'platform admin')
    user_roles = UserRole.create(user_id: pa.id, role_id: role.id)
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
