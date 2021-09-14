FactoryBot.define do
  factory :item, class: Item do
    association :merchant
    name { Faker::Commerce.unique.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { Faker::Number.within(range: 1..100000) }
    id { Faker::Number.unique.within(range: 1..100) }
  end
end
