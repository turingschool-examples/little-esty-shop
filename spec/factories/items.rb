FactoryBot.define do
  factory :item do
    sequence(:id)
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.between(from: 1, to: 1000) }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }

    association :merchant
  end
end
