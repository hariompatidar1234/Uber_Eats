FactoryBot.define do
  factory :dish do
    name { Faker::Food.dish }
    price {70}
    category { association :category }
    restaurant { association :restaurant}
  end
end
