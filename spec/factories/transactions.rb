require 'faker'
FactoryBot.define do
  factory :transaction do
    association :invoice, factory: :invoice
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.in_date_period }
  end
end
