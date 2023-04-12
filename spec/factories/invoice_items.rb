FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.between(from: 1, to: 10) }
    unit_price { Faker::Number.between(from: 100, to: 1000) }
    status { InvoiceItem.statuses.keys.sample }
    created_at { Faker::Time.between(from: 2.years.ago, to: Time.now) }
    updated_at { created_at }
  end
end