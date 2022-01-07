require 'faker'
FactoryBot.define do
  factory :invoice_item do
    association :invoice, factory: :invoice
    association :item, factory: :item
    traits_for_enum(:status)
    quantity { Faker::Number.number(digits: 2) }
    unit_price { Faker::Number.number(digits: 4) }
  end
end
