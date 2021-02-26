FactoryBot.define do
  factory :invoice_item do
    quantity {Faker::Number.within(range: 0..10)}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    status {Faker::Number.within(range: 0..2)}
  end
end
