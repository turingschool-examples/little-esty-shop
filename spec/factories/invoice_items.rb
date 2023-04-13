FactoryBot.define do
  factory :invoice_item do
    sequence(:id)
    quantity { Faker::Number.between(from: 1, to: 5) }
    unit_price { Faker::Number.between(from: 1, to: 1000) }
    status { Faker::Number.between(from: 0, to: 2) }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }

    association :invoice, :item
  end
end
