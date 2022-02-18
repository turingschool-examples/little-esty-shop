FactoryBot.define do
  factory :invoice_item do
    invoice
    item

    quantity { Faker::Number.within(range: 1..500) }
    unit_price { Faker::Number.within(range: 1..100000) }
    status { 0 }
  end
end
