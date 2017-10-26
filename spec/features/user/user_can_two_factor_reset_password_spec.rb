require 'rails_helper'

describe 'A user that is not logged in' do
  it 'can request a code to change their forgotten password' do
    role = Role.create(name: 'registered')
    user = create(:user, reset_code: '123456')
    user_role = UserRole.create(user: user, role: role)
    new_password = 'newpassword'
    allow(ConfirmationSender).to receive(:send_confirmation_sms).and_return(true)

    visit '/login'
    click_on 'Forgot my Password'

    expect(current_path).to eq('/password-reset')
    fill_in 'username', with: "#{user.username}"
    click_on 'Submit'

    expect(current_path).to eq('/password-confirmation')
    expect(page).to have_content('Please enter the code and')

    fill_in 'reset_code', with: "#{user.reset_code}"
    fill_in 'password', with: "#{new_password}"
    fill_in 'password_confirmation', with: "#{new_password}"
    click_on 'Submit'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("#{user.full_name}")

    click_on 'Logout'
    click_on 'Login'
    fill_in 'Username', with: "#{user.username}"
    fill_in 'Password', with: 'password'
    page.find(:css, '.login-button').click

    expect(current_path).to eq('/login')

    fill_in 'Username', with: "#{user.username}"
    fill_in 'Password', with: "#{new_password}"
    page.find(:css, '.login-button').click

    expect(current_path).to eq('/dashboard')
  end
end
