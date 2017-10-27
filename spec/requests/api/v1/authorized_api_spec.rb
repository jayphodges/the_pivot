require 'rails_helper'

describe 'Secure API' do
  context 'user authorization' do
    it 'will serve endpoint to authorized user' do
      Role.create(name: "registered")
      user = create(:user)
      user_name = user.username
      store1 = create(:store)
      store2 = create(:store)
      order1 = create(:order, user: user, status: 3, store: store1)
      order2 = create(:order, user: user, status: 3, store: store2)
      c = Category.create(title: "Guitars")
      item1 = create(:item, category_id: c.id, store: store1, price: 50)
      item2 = create(:item, category_id: c.id, store: store2, price: 200)

      order1.items << item1
      OrdersItem.last.update(unit_price: item1.price)
      order1.items << item1
      OrdersItem.last.update(unit_price: item1.price)
      order1.items << item1
      OrdersItem.last.update(unit_price: item1.price)
      order2.items << item2
      OrdersItem.last.update(unit_price: item2.price)

      auth = ActionController::HttpAuthentication::Basic.encode_credentials(user_name, 'password')

      get "http://localhost:3000/api/v1/top_selling_stores", headers: { 'Authorization' => auth}

      expect(response).to be_success

      reply = JSON.parse(response.body)

      expect(reply.first[1]).to eq(200.0)
      expect(reply.count).to eq(2)
    end
    it 'will not serve an unauthorized user' do
      get "http://localhost:3000/api/v1/top_selling_stores"

      expect(response.status).to eq(401)
    end
  end

  context 'API Endpoints' do
    it 'will serve most_active_customer' do
      Role.create(name: "registered")
      user = create(:user)
      user_name = user.username
      store = create(:store)
      auth = ActionController::HttpAuthentication::Basic.encode_credentials(user_name, 'password')
      user2 = create(:user)
      order1 = create(:order, user: user, status: 3, store: store)
      order2 = create(:order, user: user2, status: 3, store: store)
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

      get "http://localhost:3000/api/v1/most_active_customers", headers: { 'Authorization' => auth}

      reply = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(reply.first[0]).to eq(user2.full_name)
    end
    it 'will serve most_sold_items' do
      Role.create(name: "registered")
      user = create(:user)
      user_name = user.username
      store = create(:store)
      auth = ActionController::HttpAuthentication::Basic.encode_credentials(user_name, 'password')
      user2 = create(:user)
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

      get "http://localhost:3000/api/v1/most_sold_items", headers: { 'Authorization' => auth}

      reply = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(reply.first[0]).to eq(item1.title)
    end
    it 'will serve most_expensive_orders' do
      Role.create(name: "registered")
      user = create(:user)
      user_name = user.username
      store = create(:store)
      auth = ActionController::HttpAuthentication::Basic.encode_credentials(user_name, 'password')
      user2 = create(:user)
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

      get "http://localhost:3000/api/v1/most_expensive_orders", headers: { 'Authorization' => auth}

      reply = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(reply.first[0]).to eq(order2.id)
    end
    it 'will serve top_selling_items' do
      Role.create(name: "registered")
      user = create(:user)
      user_name = user.username
      store = create(:store)
      auth = ActionController::HttpAuthentication::Basic.encode_credentials(user_name, 'password')
      user2 = create(:user)
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

      get "http://localhost:3000/api/v1/top_selling_items", headers: { 'Authorization' => auth}

      reply = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(reply.first[0]).to eq(item1.title)
    end
  end
end
