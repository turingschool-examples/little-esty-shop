FactoryBot.define do
  factory :invoice_item do
    item_id { Faker::Number.between(from: 1, to: 20) }
    invoice_id { Faker::Number.between(from: 1, to: 20) }
    quantity { Faker::Number.between(from: 1, to: 10) }
    unit_price { Faker::Number.digits(5) }
    status { [0, 1, 2].sample }
  end
end
