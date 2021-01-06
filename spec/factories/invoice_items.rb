FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 50) }
    unit_price { Faker::Number.number(digits: 3) }
    status { Faker::Number.between(from: 0, to: 2) }
  end
end
