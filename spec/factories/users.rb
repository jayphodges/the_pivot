FactoryBot.define do
  factory :user do

    sequence :username do |i|
    	"Username#{i}"
    end

    password 'password'

    sequence :full_name do |i|
    	"firstname lastname #{i}"
    end

    sequence :address do |i|
    	"#{i} streetname, street"
    end
  end
end
