FactoryBot.define do
  factory :transaction, class: Transaction do
    association :invoice

    credit_card_number { Faker::Number.number(digits: 16).to_s }
    result { ["success", "failed"].sample }
    id { Faker::Number.unique.within(range: 1..1000000) }
  end
end
