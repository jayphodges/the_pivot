require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it 'is invalid without a title' do
        category = Category.create(title: "")

        expect(category).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with valid attributes" do
        category = create(:category)

        expect(category).to be_valid
      end
    end
  end
end
