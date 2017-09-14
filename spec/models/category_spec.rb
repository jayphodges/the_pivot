require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it 'is invalid without a title' do
        category = Category.create(title: "")

        expect(category).to be_invalid
      end
    end
  end
end
