require 'faker'

FactoryBot.define do
  factory :customer, class: Customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :merchant, class: Merchant do
    name { Faker::Name.name }
  end

  factory :item, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price { Faker::Number.within(range: 10..1_000) }
    status { 0 }
    association :merchant, factory: :merchant
  end

  factory :invoice, class: Invoice do
    status { Faker::Number.within(range: 0..2) }
    association :customer, factory: :customer
  end

  factory :invoice_item, class: InvoiceItem do
    # status_hash = {0 => 'pending', 1 => 'packaged', 2 => 'shipped'}
    quantity { Faker::Number.within(range: 0..10) }
    unit_price { Faker::Number.within(range: 100..1_000) }
    status { Faker::Number.within(range: 0..2) }
    association :invoice, factory: :invoice
    association :item, factory: :item
  end

  factory :transaction, class: Transaction do
    result_hash = { 0 => 'success', 1 => 'failed' }
    credit_card_number { Faker::Bank.account_number }
    credit_card_expiration_date { Faker::Date.between(from: '2030-01-01', to: '2040-12-31') }
    result { result_hash[Faker::Number.within(range: 0..1)] }
    association :invoice, factory: :invoice
  end

  factory :discount, class: Discount do
    quantity_threshold { Faker::Number.within(range: 5..100) }
    percentage_discount { Faker::Number.within(range: 1..100) }
    association :merchant, factory: :merchant
  end
end
