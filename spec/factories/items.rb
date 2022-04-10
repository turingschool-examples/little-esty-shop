FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Commerce.product_name}
    description { Faker::Books::Lovecraft.sentences}
    unit_price { Faker::Number.within(range: 1..100_000)}
    id { Faker::Number.unique.within(range: 1..100_000)}
    created_at { Faker::Date.between(from: '2014-09-23', to: '2015-09-23')}
    updated_at { Faker::Date.between(from: '2016-09-23', to: '2017-09-23')}
  end
end
