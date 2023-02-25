FactoryBot.define do
  factory :merchant do
    sequence(:id)
    sequence(:uuid)
    name { Faker::Name.name }
    created_at {Time.zone.now}
    updated_at {Time.zone.now}
  end
end 