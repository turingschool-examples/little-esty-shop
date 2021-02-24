FactoryBot.define do
  factory :transaction do
    credit_card_number {Faker::Business.credit_card_number}
    credit_card_expiration_date {"null"}
    result {Faker::Number.within(range: 0..1)}
  end
end
