FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 50) }
    unit_price { Faker::Number.between(from: 1, to: 3) }
    status { 0 }
  end
end
