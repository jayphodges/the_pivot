FactoryBot.define do
  factory :store do

    sequence :name do |i|
      "name #{i}"
    end

    status 1
  end
end
