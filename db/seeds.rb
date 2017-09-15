require 'faker'

Category.destroy_all
Item.destroy_all

Category.create!(title: "Guitars")
Category.create!(title: "Keyboards")
Category.create!(title: "Synth")
Category.create!(title: "Drums")

categories = Category.all

20.times do |num|
  category = categories.shuffle.first

	puts "created #{category.title}"

	item = Item.create(title: Faker::Music.instrument, description: Faker::RickAndMorty.quote, price: num + rand(5), image: "http://lorempixel.com/400/400", category_id: category.id)

	puts "Created #{item.title} with category #{item.category.title}"
end