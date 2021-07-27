FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card(:mastercard) }
    credit_card_expiration_date { Faker::String.random(length: 5) }
    result { 'In Progress' }
    invoice
  end
end