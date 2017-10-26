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
        user = User.create(username: 'sam', password: '123', full_name: 'Sam Lim', address: 'foo.png')

        expect(user).to be_invalid
      end
    end
  end
end
