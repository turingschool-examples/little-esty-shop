FactoryBot.define do
  factory :item do
    sequence(:id)
    sequence(:uuid)
    name {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence}
    unit_price { Faker::Commerce.price(range: 0..100.0, as_string: false) }
    created_at {Time.zone.now}
    updated_at {Time.zone.now}

    association :merchant
  end
end 