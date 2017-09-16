require 'rails_helper'

RSpec.describe Order, type: :model do
  context "invalid attributes" do
    it 'is invalid without a user id' do
      order = Order.create(status: 1)

      expect(order).to be_invalid
    end

    it 'is invalid without a status' do
      user = create(:user)
      order = Order.create(user_id: user.id, status: "")

      expect(order).to be_invalid
    end
  end

  context "valid attributes" do
    it 'is valid with a status and user_id' do
      user = create(:user)
      order = create(:order, user_id: user.id)

      expect(order).to be_valid
    end
  end
end
