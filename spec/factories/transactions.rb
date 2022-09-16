FactoryBot.define do
  factory :random_transaction, class: Transaction do
    quantity        {Faker::Number.between(from: 1, to: 10)}
    unit_price {Faker::Number.between(from: 1000, to: 98000)}
    association :invoice, factory: :random_invoice
  end
end