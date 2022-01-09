FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Number.number(digits: 16).to_s }
    result { [0, 1].sample }
    id { Faker::Number.unique.within(range: 1..100_000) }
  end
end
