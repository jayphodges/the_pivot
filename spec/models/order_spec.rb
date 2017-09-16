require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
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

  describe "methods" do
    context "instance methods" do
      it '#total_order_price' do
        user = create(:user)
        order = create(:order, user: user, status: 1)
        category = create(:category)
        item_1 = order.items.create(title: "Cool Item", description: "Descrip",
                                    price: 35.0, image: "http://lorempixel.com/400/200",
                                    category: category)
        item2 = order.items.create(title: "Cool Item2", description: "Descrip2",
                                   price: 35.50, image: "http://lorempixel.com/400/200",
                                   category: category)
        item3 = order.items.create(title: "Cool Item3", description: "Descrip3",
                                   price: 35.99, image: "h`ttp://lorempixel.com/400/200",
                                   category: category)

        expect(order.total_order_price).to eq('106.49')
      end

      it '#item_quantity' do
        user = create(:user)
        order = create(:order, user: user, status: 1)
        category = create(:category)
        item_1 = order.items.create(title: "Cool Item", description: "Descrip",
                                    price: 35.0, image: "http://lorempixel.com/400/200",
                                    category: category)
        item2 = order.items.create(title: "Cool Item2", description: "Descrip2",
                                   price: 35.50, image: "http://lorempixel.com/400/200",
                                   category: category)
        item3 = order.items.create(title: "Cool Item3", description: "Descrip3",
                                   price: 35.99, image: "h`ttp://lorempixel.com/400/200",
                                   category: category)
        4.times do
          order.items << item_1
        end

        expect(order.item_quantity(item_1)).to eq(5)
      end

      it '#item_subtotal' do
        user = create(:user)
        order = create(:order, user: user, status: 1)
        category = create(:category)
        item_1 = order.items.create(title: "Cool Item", description: "Descrip",
                                    price: 35.0, image: "http://lorempixel.com/400/200",
                                    category: category)
        item2 = order.items.create(title: "Cool Item2", description: "Descrip2",
                                   price: 35.50, image: "http://lorempixel.com/400/200",
                                   category: category)
        item3 = order.items.create(title: "Cool Item3", description: "Descrip3",
                                   price: 35.99, image: "h`ttp://lorempixel.com/400/200",
                                   category: category)
        4.times do
          order.items << item_1
        end

        expect(order.item_subtotal(item_1)).to eq('175.00')
      end
    end
  end
end
