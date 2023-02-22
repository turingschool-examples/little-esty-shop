FactoryBot.define do
  factory :transaction do
    invoice_id {Faker::Number.within(range: 1..900)}
    credit_card_number {Faker::Number.number(digits: 16)}
    credit_card_expiration_date { nil }
    result {["success", "failed"].shuffle.first}
  end
end
