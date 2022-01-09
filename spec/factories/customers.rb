FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    id { Faker::Number.unique.within(range: 1..100_000)}
  end
end
