FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card }
    credit_card_expiration_date { Faker::Number.between(from: 1021, to: 1220) }
    result { 0 }
  end
end
