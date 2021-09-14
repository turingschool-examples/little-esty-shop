FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    association :item
    association :invoice
    quantity { Faker::Number.within(range: 1..100) }
    unit_price { Faker::Number.within(range: 1..100000) }
    status { [0, 1, 2].sample }
    id { Faker::Number.unique.within(range: 1..100) }
  end
end
