FactoryGirl.define do
  factory :user do

    sequence :username do |i|
    	"Username#{i}"
    end

    sequence :password do |i|
    	"password#{i}"
    end

    sequence :full_name do |i|
    	"firstname lastname #{i}"
    end

    sequence :address do |i|
    	"#{i} streetname, street"
    end
  end
end
