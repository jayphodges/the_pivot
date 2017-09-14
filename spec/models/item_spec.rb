require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it 'is invalid without a title' do
        category = Category.create(title: "Guitars")
        item = Item.create(description: "desc",
          price: 5.5, image: 'foo.png', category_id: category.id)

        expect(item).to be_invalid
      end

      it 'is invalid without a description' do
        category = Category.create(title: "Guitars")
        item = Item.create(title: "title",
          price: 5.5, image: 'foo.png', category_id: category.id)

        expect(item).to be_invalid
      end

      it 'is invalid without a price' do
        category = Category.create(title: "Guitars")
        item = Item.create(title: 'title', description: "desc",
          image: 'foo.png', category_id: category.id)

        expect(item).to be_invalid
      end

      it 'is invalid without an image' do
        category = Category.create(title: "Guitars")
        item = Item.create(title: 'title', description: "desc",
          price: 5.5, category_id: category.id)

        expect(item).to be_invalid
      end

      it 'is invalid without a category' do
        category = Category.create(title: "Guitars")
        item = Item.create(title: 'title', description: "desc",
          price: 5.5, image: 'foo.png')

        expect(item).to be_invalid
      end

      it 'is invalid if title is not unique' do
        c = Category.create(title: "Guitars")
        Item.create(title: 'title', description: "desc",
          price: 5.5, image: 'foo.png', category_id: c.id)
        item = Item.create(title: 'title', description: "desc",
          price: 5.5, image: 'foo.png', category_id: c.id)

        expect(item).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with valid attributes" do
        c = Category.create(title: "Guitars")
        item = Item.create(title: 'title', description: "desc",
          price: 5.5, image: 'foo.png', category_id: c.id)


        expect(item).to be_valid
      end
    end
  end
end
