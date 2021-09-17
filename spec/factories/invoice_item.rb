FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    quantity { Faker::Number.number(digits: 4)}
    unit_price { Faker::Number.number(digits: 2) }
    status { 1 }
    created_at { "2019-02-27 10:52:09 UTC" }
    updated_at { "2020-03-27 14:32:09 UTC" }
  end
end
