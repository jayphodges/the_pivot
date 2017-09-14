describe Cart do
  context "instance methods" do
    before(:each) do
      c = Category.create(title: "Guitars")
      @item = Item.create(title: 'title', description: "desc",
        price: 5.5, image: 'foo.png', category_id: c.id)
      @cart = Cart.new({})
    end

    it '.add_item' do
      expect(@cart.contents).to eq({})

      @cart.add_item(@item.id)

      expect(@cart.contents).to eq({@item.id.to_s => 1})
    end

    it '.update_item' do
      @cart.add_item(@item.id)
      @cart.update_item(@item.id, 12)

      expect(@cart.contents).to eq({@item.id.to_s => 12})
    end
  end
end