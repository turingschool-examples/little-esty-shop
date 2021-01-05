FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.between(from: Date.today, to: 1.year.from_now) }
    result { Faker::Number.between(from: 0, to: 1) }
  end
end
