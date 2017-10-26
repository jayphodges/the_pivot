require 'rails_helper'

RSpec.describe Order, type: :model do

  describe "validations" do
    context "invalid attributes" do
      it 'is invalid without a user id' do
        order = Order.create(status: 1)

        expect(order).to be_invalid
      end

      it 'is invalid without a status' do
        Role.create(name: "registered")
        user = create(:user)
        order = Order.create(user_id: user.id, status: "")

        expect(order).to be_invalid
      end
    end

    context "valid attributes" do
      it 'is valid with a status and user_id' do
        Role.create(name: "registered")
        user = create(:user)
        order = create(:order, user_id: user.id)

        expect(order).to be_valid
      end
    end
  end

  describe "methods" do
    context "instance methods" do
      it '#total_order_price' do
        Role.create(name: "registered")
        user = create(:user)
        store = create(:store)
        order = create(:order, user: user, status: 1)
        category = create(:category)
        item_1 = order.items.create(title: "Cool Item", description: "Descrip",
                                    price: 35.0, image: "http://lorempixel.com/400/200",
                                    category: category, store: store)
        item2 = order.items.create(title: "Cool Item2", description: "Descrip2",
                                   price: 35.50, image: "http://lorempixel.com/400/200",
                                   category: category, store: store)
        item3 = order.items.create(title: "Cool Item3", description: "Descrip3",
                                   price: 35.99, image: "http://lorempixel.com/400/200",
                                   category: category, store: store)

        OrdersItem.where(item_id: item_1.id).update(unit_price: 35.0)
        OrdersItem.where(item_id: item2.id).update(unit_price: 35.50)
        OrdersItem.where(item_id: item3.id).update(unit_price: 35.99)

        expect(order.total_order_price).to eq('106.49')
      end

      it '#item_quantity' do
        Role.create(name: "registered")
        user = create(:user)
        order = create(:order, user: user, status: 1)
        store = create(:store)
        category = create(:category)
        item_1 = order.items.create(title: "Cool Item", description: "Descrip",
                                    price: 35.0, image: "http://lorempixel.com/400/200",
                                    category: category, store: store)
        item2 = order.items.create(title: "Cool Item2", description: "Descrip2",
                                   price: 35.50, image: "http://lorempixel.com/400/200",
                                   category: category, store: store)
        item3 = order.items.create(title: "Cool Item3", description: "Descrip3",
                                   price: 35.99, image: "http://lorempixel.com/400/200",
                                   category: category, store: store)
        4.times do
          order.items << item_1
        end

        expect(order.item_quantity(item_1)).to eq(5)
      end

      it '#item_subtotal' do
        Role.create(name: "registered")
        user = create(:user)
        order = create(:order, user: user, status: 1)
        store = create(:store)
        category = create(:category)
        item_1 = order.items.create(title: "Cool Item", description: "Descrip",
                                    price: 35.0, image: "http://lorempixel.com/400/200",
                                    category: category, store: store)
        item2 = order.items.create(title: "Cool Item2", description: "Descrip2",
                                   price: 35.50, image: "http://lorempixel.com/400/200",
                                   category: category, store: store)
        item3 = order.items.create(title: "Cool Item3", description: "Descrip3",
                                   price: 35.99, image: "http://lorempixel.com/400/200",
                                   category: category, store: store)


        4.times do
          order.items << item_1
        end

        OrdersItem.where(item_id: item_1.id).update(unit_price: 35.0)
        OrdersItem.where(item_id: item2.id).update(unit_price: 35.50)
        OrdersItem.where(item_id: item3.id).update(unit_price: 35.99)

        expect(order.item_subtotal(item_1)).to eq('175.00')
      end

      it '#add_items' do
        Role.create(name: "registered")
        user = create(:user)
        order = create(:order, user: user, status: 1)
        store = create(:store)
        category = create(:category)
        item_1 = order.items.create(title: "Cool Item", description: "Descrip",
                                    price: 35.0, image: "http://lorempixel.com/400/200",
                                    category: category, store: store)
        cart = Cart.new({item_1.id => 10})


        expect(order.add_items(cart)).to eq({item_1.id => 10})
      end
    end

    context "class methods" do
      it '.orders_by_month' do
        Role.create(name: "registered")
        user = create(:user)
        order = create(:order, user: user, status: 1)
        store = create(:store)
        c = Category.create(title: "Guitars")
        10.times do
          order.items.create(title: "Cool Item", description: "Descrip",
                             price: 35.0, image: "http://lorempixel.com/400/200",
                             category: c, store: store,
                             created_at: rand(1.years).seconds.ago)
        end

        expect(Order.orders_by_month.values).to be_a(Array)
      end

      it '.orders_by_month' do
        Role.create(name: "registered")
        user = create(:user)
        order = create(:order, user: user, status: 1)
        store = create(:store)
        c = Category.create(title: "Guitars")
        10.times do
          order.items.create(title: "Cool Item", description: "Descrip",
                             price: 35.0, image: "http://lorempixel.com/400/200",
                             category: c, store: store,
                             created_at: rand(1.years).seconds.ago)
        end

        expect(Order.orders_by_day_of_week.values).to be_a(Array)
      end

      it '.most_expensive_orders' do
        role = Role.create(name: "registered")
        user = create(:user)
        store = create(:store)
        order1 = create(:order, user: user, status: 3, store: store)
        order2 = create(:order, user: user, status: 3, store: store)
        c = Category.create(title: "Guitars")
        item1 = create(:item, category_id: c.id, store: store, price: 50)
        item2 = create(:item, category_id: c.id, store: store, price: 200)

        order1.items << item1
        OrdersItem.last.update(unit_price: item1.price)
        order1.items << item1
        OrdersItem.last.update(unit_price: item1.price)
        order1.items << item1
        OrdersItem.last.update(unit_price: item1.price)
        order2.items << item2
        OrdersItem.last.update(unit_price: item2.price)

        result = Order.most_expensive_orders

        expect(result.first[0]).to eq(order2.id)
        expect(result.keys[1]).to eq(order1.id)
      end
    end
  end
end
