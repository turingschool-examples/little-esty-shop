FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card }
    credit_card_expiration_date { Faker::Date.between(from: "2020-09-20", to: "2022-09-25") }
    result { 1 }
    invoice { nil }
  end
end
