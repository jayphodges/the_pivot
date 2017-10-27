require 'rails_helper'

describe 'As a platform admin' do
  it 'I can view reports' do
    Role.create(name: "registered")
    role = Role.create(name: "platform admin")
    user = User.create(username: "David Bowie",
                       password: "Goblin King",
                       full_name: "Ziggy Stardust",
                       address: "Labyrinth", phone: '1234567890')
    user_role = UserRole.create(user: user, role: role)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_reports_path

    expect(page).to have_content("Most Active Customers")
  end
end
