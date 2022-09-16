FactoryBot.define do
  factory :random_transaction, class: Transaction do
    credit_card_number   {Faker::Number.number(digits: 16)}
    credit_card_expiration_date {}
    result {Faker::Number.between(from: 0, to: 1)}  
    association :invoice, factory: :random_invoice
  end
end