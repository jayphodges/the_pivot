FactoryBot.define do
  factory :category do
    sequence :title do |t| 
      "Title#{t}"
    end
  end
end
