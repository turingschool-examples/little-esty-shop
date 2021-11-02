FactoryBot.define do
  factory :item, class: Item do
    association :merchant

    name { Faker::Commerce.product_name }
    description { Faker::Hipster.sentence }
    unit_price { Faker::Number.within(range: 1..100000)  }
    id { Faker::Number.unique.within(range: 1..1000000) }
  end
end
