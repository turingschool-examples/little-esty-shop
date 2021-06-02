FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 12) }
    credit_card_expiration_date { '' }
  end
end