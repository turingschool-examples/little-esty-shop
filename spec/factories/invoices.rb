FactoryBot.define do
  factory :invoice do
    sequence(:id)
    sequence(:uuid)
    status {Faker::Number.between(from: 0, to: 2)}
    created_at {Time.zone.now}
    updated_at {Time.zone.now}

    association :customer
    
  end
end 