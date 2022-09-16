FactoryBot.define do
  factory :random_invoice_item, class: InvoiceItem do
    quantity        {Faker::Number.between(from: 1, to: 10)}
    unit_price {Faker::Number.between(from: 1000, to: 98000)}
    status     {Faker::Number.between(from: 0, to: 2)}
    association :invoice, factory: :random_invoice
    association :item, factory: :random_item
  end
end