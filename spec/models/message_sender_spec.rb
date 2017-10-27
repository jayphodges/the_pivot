require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "methods" do
    context "instance methods" do
      it "sends code" do
        allow(MessageSender).to receive(:send_code).and_return(true)
        response = MessageSender.send_code('7608675309', 'user')

        expect(response).to eq(true)
      end
    end
  end
end
