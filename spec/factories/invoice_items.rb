FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..1000) }
    unit_price { Faker::Number.number(digits: 7) }
    status { ['pending', 'packaged', 'shipped'].sample }
    invoice { nil }
    item { nil }
  end
end
