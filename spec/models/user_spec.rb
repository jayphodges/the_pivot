require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it 'is invalid without a username' do
        user = User.create(username: '', password: '123', full_name: 'Sam Lim', address: 'Foo Street')

        expect(user).to be_invalid
      end

      it 'is invalid without a password' do
        user = User.create(username: 'sam', password: '', full_name: 'Sam Lim', address: 'Foo Street')

        expect(user).to be_invalid
      end

      it 'is invalid without a full name' do
        user = User.create(username: 'sam', password: '123', full_name: '', address: 'Foo Street')

        expect(user).to be_invalid
      end

      it 'is invalid without an address' do
        user = User.create(username: 'sam', password: '123', full_name: 'Sam Lim', address: '')

        expect(user).to be_invalid
      end
    end

    context "uniqueness" do
      it 'is invalid without a unique username' do
        Role.create(name: "registered")
        create(:user, username: 'sam')
        user = User.create(username: 'sam', password: '123', full_name: 'Sam Lim', address: 'foo.png', phone: '1234567890')

        expect(user).to be_invalid
      end
    end

    context 'test for user role' do
      it 'platform_admin?' do
        role = Role.create(name: "registered")
        role = Role.create(name: "platform admin")
        user = create(:user)
        UserRole.create(role: role, user: user)

        expect(user.platform_admin?).to eq(true)
      end
      it 'business_admin?' do
        role = Role.create(name: "registered")
        role = Role.create(name: "business admin")
        user = create(:user)
        UserRole.create(role: role, user: user)

        expect(user.business_admin?).to eq(true)
      end
      it 'business_manager?' do
        role = Role.create(name: "registered")
        role = Role.create(name: "business manager")
        user = create(:user)
        UserRole.create(role: role, user: user)

        expect(user.business_manager?).to eq(true)
      end
      it 'registered?' do
        role = Role.create(name: "registered")
        user = create(:user)
        UserRole.create(role: role, user: user)

        expect(user.registered?).to eq(true)
      end
    end
  end
end
