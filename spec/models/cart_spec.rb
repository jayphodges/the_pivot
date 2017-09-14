describe Cart do
  context "instance methods" do
    it '.add_item' do
      c = Category.create(title: "Guitars")
      Item.create(title: 'title', description: "desc",
        price: 5.5, image: 'foo.png', category_id: c.id)
      cart = Cart.new({})

      expect(cart.contents).to eq({})
    end
  end
end