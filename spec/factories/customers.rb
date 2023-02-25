FactoryBot.define do
  factory :customer do
    sequence(:id)
    sequence(:uuid)
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    created_at {Time.zone.now}
    updated_at {Time.zone.now}
  end
end 