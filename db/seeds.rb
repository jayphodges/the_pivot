require 'faker'

Category.destroy_all
Item.destroy_all

Category.create!(title: "Guitars")
Category.create!(title: "Keyboards")
Category.create!(title: "Synth")
Category.create!(title: "Drums")

categories = Category.all
user = User.create(username: 'sam', password: 'sam', role: 0)

60.times do |num|
  category = categories.shuffle.first

  order = user.orders.create(status: 1, created_at: rand(1.years).seconds.ago)

  puts "created #{category.title}"

  item = order.items.create(title: Faker::Music.instrument, description: Faker::RickAndMorty.quote, price: num + rand(5), image: "http://lorempixel.com/400/400", category_id: category.id, created_at: rand(1.years).seconds.ago)

  puts "Created #{item.title} with category #{item.category.title}"
end

User.create(username: 'admin', password: 'admin', role: 'admin')