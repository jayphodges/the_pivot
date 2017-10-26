require 'rails_helper'

xdescribe 'A user that is not logged in' do
  it 'can request a code to change their forgotten password' do
    user = create(:user, reset_code: '123456')
    new_password = 'newpassword'

    visit '/login'
    click_on 'Forgot my Password'

    expect(current_path).to eq('/password-reset')

    fill_in 'username', with: "#{user.username}"
    click_on 'Submit'

    expect(current_path).to eq('/password-confirmation')
    expect(page).to have_content('Please enter the code and')

    fill_in 'reset_code', with: "#{user.reset_code}"
    fill_in 'password', with: 'newpassword'
    fill_in 'password_confirmation', with: "#{new_password}"
    click_on 'Submit'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("#{user.full_name}")

    click_on 'Logout'
    click_on 'Login'
    fill_in 'Username', with: "#{user.username}"
    fill_in 'Password', with: 'password'

    expect(current_path).to eq('/login')

    fill_in 'Username', with: "#{user.username}"
    fill_in 'Password', with: "#{new_password}"

    expect(current_path).to eq('/dashboard')
  end
end
# As a guest user
# When I visit "/login"
# And I click "Forgot my Password"
# Then I should be on '/password-reset'
#
# When I fill in `Email` with "josh@example.com"
# And I click `Submit`
# Then I should be redirected to "/password-confirmation"
# And I should see instructions to enter my confirmation code
# And I should have received a text message with a confirmation code
#
# When I enter the confirmation code
# And I fill in `Password` with `password`
# And I fill in `Password Confirmation` with `password`
# And I click "Submit"
# Then I should be redirected to "/dashboard"
# And I should be logged in
# And my old password should no longer work for logging in
# And my new password should work after logging out and logging back in

