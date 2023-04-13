FactoryBot.define do
  factory :customer do
    sequence(:id)
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
