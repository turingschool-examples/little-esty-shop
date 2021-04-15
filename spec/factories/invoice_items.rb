
FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..10) }
    status { rand(0..2) }
    unit_price { Faker::Number.number(digits: 5) }
    invoice
    item
  end
end
