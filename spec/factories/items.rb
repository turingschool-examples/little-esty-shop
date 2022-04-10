FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Commerce.product_name}
    description { Faker::JeffGoldblum.fact}
    unit_price { Faker::Number.within(range: 1..100_000)}
    id { Faker::Number.unique.within(range: 1..100_000)}
  end
end
