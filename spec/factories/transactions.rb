FactoryBot.define do
  factory :transaction do
    credit_card_number {Faker::Number.within(range: 400000000000..49999999999)}
    credit_card_expiration_date {Faker::Date.forward(days: 365)}
    result {[0, 1].sample}
  end
end
