FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.leading_zero_number(digits: 16) }
    credit_card_expiration_date { Faker::Number.leading_zero_number(digits: 4) }
    result { ['success', 'failed'].sample }
    invoice { nil }
  end
end
