Category.destroy_all
Item.destroy_all

Category.create!(title: "Guitars")
Category.create!(title: "Keyboards")
Category.create!(title: "Synth")
Category.create!(title: "Drums")

categories = Category.all

categories.each do |category|
	puts "created #{category.title}"
	10.times do |num|
		Item.create(title: "title#{num}", description: "descrip#{num}", price: num + rand(5), image: "http://lorempixel.com/400/200", category_id: category.id)
	end
	items = Item.pluck(:title)
	puts "Created #{items}"
end