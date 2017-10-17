require 'rails_helper'

describe Cart do
  context "instance methods" do
    before(:each) do
      @c = Category.create(title: "Guitars")
      @item = Item.create(title: 'title', description: "desc",
        price: 5.5, image: 'http://lorempixel.com/400/200', category_id: @c.id)
      @cart = Cart.new({})
    end

    it '#add_item' do
      expect(@cart.contents).to eq({})

      @cart.add_item(@item.id)

      expect(@cart.contents).to eq({@item.id.to_s => 1})
    end

    it '#update_item' do
      @cart.add_item(@item.id)
      @cart.update_item(@item.id, 12)

      expect(@cart.contents).to eq({@item.id.to_s => 12})
    end

    it '#subtotal' do
      @cart.add_item(@item.id)
      @cart.update_item(@item.id, 12)

      expect(@cart.subtotal(@item)).to eq((12 * 5.5).to_s + '0')
    end

    it '#total' do
      item_2 = Item.create(title: 'title2', description: "desc",
        price: 10, image: 'http://lorempixel.com/400/200', category_id: @c.id)
      @cart.add_item(@item.id)
      @cart.add_item(item_2.id)

      expect(@cart.total).to eq('15.50')
    end

    it '#quantity' do
      @cart.add_item(@item.id)

      expect(@cart.quantity(@item)).to eq(1)

      @cart.add_item(@item.id)

      expect(@cart.quantity(@item)).to eq(2)
    end
  end
end