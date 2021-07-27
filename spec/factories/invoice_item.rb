FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 50) }
    unit_price { Faker::Number.between(from: 20, to: 2000) }
    status { 0 }
  end
end
