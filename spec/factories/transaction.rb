FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card(:mastercard) }
    credit_card_expiration_date { "#{Faker::Number.between(from: 1, to: 12)}/#{Faker::Number.between(from: 21, to: 25)}" }
    result { 'In Progress' }
    invoice
  end
end