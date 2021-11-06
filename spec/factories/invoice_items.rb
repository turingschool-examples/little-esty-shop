FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.number(digits: 2) }
    unit_price { Faker::Number.number(digits: 4) }
    status { ['packaged', 'pending', 'shipped'].sample }
  end
end
