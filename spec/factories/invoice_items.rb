FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 5) }
    unit_price { Faker::Number.between(from: 1, to: 10) }
    status { 1 }
    item { nil }
    invoice { nil }
  end
end
