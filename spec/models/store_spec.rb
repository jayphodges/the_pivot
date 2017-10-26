require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validations" do
    context "valid attributes" do
      it "is valid with name" do
        store = Store.create(name: "Shop")

        expect(store).to be_valid
      end
      it "is valid with name and slug" do
        store = Store.create(name: "Shop", slug: "shop")

        expect(store).to be_valid
      end
    end
  end

  describe "instance methods" do
    context "generate_slug" do
      it 'creates slug based on store name' do
        store = Store.create(name: "Shop")

        expect(store.slug).to eq(store.name.parameterize)
      end
    end

    context "top_selling_stores" do
      it 'returns stores with highest revenue.' do
        role = Role.create(name: "registered")
        user = create(:user)
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

        expect(Store.top_selling_stores.first[0]).to eq(store2.id)
      end
    end
  end
end
