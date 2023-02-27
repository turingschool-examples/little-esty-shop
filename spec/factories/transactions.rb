FactoryBot.define do
  factory :transaction do
    credit_card_number {Faker::Number.number(digits: 16)}
    credit_card_expiration_date {Faker::Date.in_date_period}
    result { "success"}
    association :invoice

    trait :failed do 
      result {"failed"}
    end

    factory :failed_transaction, traits: [:failed]
  end
end