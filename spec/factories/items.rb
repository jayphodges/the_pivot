FactoryBot.define do
  factory :item do

    sequence :title do |i|
    	"title#{i}"
    end

    sequence :description do |i|
    	"descrip#{i}"
    end

    price {rand(100.0)}

    image { File.new("#{Rails.root}/spec/support/fixtures/no_image_placeholder.png") }

    category
    store
  end
end
