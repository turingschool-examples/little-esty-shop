FactoryBot.define do
  factory :invoice_item do
    sequence(:id)
    sequence(:uuid)
    quantity { Faker::Number.between(from: 1, to: 10) }
    unit_price { Faker::Commerce.price(range: 0..100.0, as_string: false) }
    status {Faker::Number.between(from: 0, to: 2)}
    created_at {Time.zone.now}
    updated_at {Time.zone.now}

    association :invoice, :item
  end
end 