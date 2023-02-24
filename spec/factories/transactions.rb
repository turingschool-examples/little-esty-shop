FactoryBot.define do
  factory :transaction do
    sequence(:id)
    sequence(:uuid)
    credit_card_number { Faker::Business.credit_card_number }
    result {Faker::Number.between(from: 0, to: 1)}
    created_at {Time.zone.now}
    updated_at {Time.zone.now}

    association :invoice
  end
end 