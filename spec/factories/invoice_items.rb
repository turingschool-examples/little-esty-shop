FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 50) }
    unit_price { Faker::Number.decimal.(l_digits: 2, r_digits: 2) }
    status { Faker::Number.between(from: 0, to: 2) }
  end
end
