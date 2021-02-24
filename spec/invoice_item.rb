FactoryBot.define do
  factory :invoie_item do
    quantity {Faker::Number.number(digits: 2)}
    unit_price {Faker::Number.decimal(l_digits: 2)}}
    status {Faker::Number.within(range: 0..2)}}
  end
end
