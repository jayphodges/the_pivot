require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it 'is invalid without a title' do
        category = Category.create(title: "Guitars")
        store = Store.create(name: "Shop")
        item = Item.create(description: "desc",
          price: 5.5, category_id: category.id)

        expect(item).to be_invalid
      end

      it 'is invalid without a description' do
        category = Category.create(title: "Guitars")
        item = Item.create(title: "title",
          price: 5.5, category_id: category.id)

        expect(item).to be_invalid
      end

      it 'is invalid without a price' do
        category = Category.create(title: "Guitars")
        item = Item.create(title: 'title', description: "desc",
         category_id: category.id)

        expect(item).to be_invalid
      end

      it 'is invalid without a category' do
        category = Category.create(title: "Guitars")
        item = Item.create(title: 'title', description: "desc",
          price: 5.5, image: 'http://lorempixel.com/400/200')

        expect(item).to be_invalid
      end

      it 'is invalid if title is not unique' do
        c = Category.create(title: "Guitars")
        Item.create(title: 'title', description: "desc",
          price: 5.5, category_id: c.id)
        item = Item.create(title: 'title', description: "desc",
          price: 5.5, category_id: c.id)

        expect(item).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with valid attributes" do
        c = Category.create(title: "Guitars")
        s = Store.create(name: "Shop", status: 0)
        item = Item.create(title: 'title', description: "desc",
          price: 5.5, category_id: c.id, store_id: s.id)


        expect(item).to be_valid
      end
    end
  end

  describe "instance methods" do
    context "price sanitization" do
      it '#formatted_price' do
        c = Category.create(title: "Guitars")
        s = Store.create(name: "Shop", status: 0)
        item = Item.create(title: 'title', description: "desc",
          price: 1.1, category_id: c.id, store_id: s.id)

        expect(item.formatted_price).to eq('1.10')
      end
    end

    context "top selling items" do
      it 'returns most sold items' do
        role = Role.create(name: "registered")
        user = create(:user)
        c = Category.create(title: "Guitars")
        s = Store.create(name: "Shop", status: 0)
        item1, item2 = create_list(:item, 2, category_id: c.id, store_id: s.id, price: 50)
        order = create(:order, status: 3)

        order.items << item1
        OrdersItem.last.update(unit_price: item1.price)
        order.items << item1
        OrdersItem.last.update(unit_price: item1.price)
        order.items << item2
        OrdersItem.last.update(unit_price: item2.price)

        result = Item.top_selling_items

        expect(result.first[0]).to eq(item1.id)
        expect(result.keys[1]).to eq(item2.id)
      end
    end

    context "most sold item" do
      it 'returns most sold items' do
        role = Role.create(name: "registered")
        user = create(:user)
        c = Category.create(title: "Guitars")
        s = Store.create(name: "Shop", status: 0)
        item1 = create(:item, category_id: c.id, store_id: s.id, price: 50)
        item2 = create(:item, category_id: c.id, store_id: s.id, price: 5000)
        order = create(:order, status: 3)

        order.items << item1
        OrdersItem.last.update(unit_price: item1.price)
        order.items << item1
        OrdersItem.last.update(unit_price: item1.price)
        order.items << item1
        OrdersItem.last.update(unit_price: item1.price)
        order.items << item2
        OrdersItem.last.update(unit_price: item2.price)

        result = Item.most_sold_items

        expect(result.first[0]).to eq(item1.id)
        expect(result.keys[1]).to eq(item2.id)
      end
    end
  end
end
