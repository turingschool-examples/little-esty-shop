FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.unique.first_name}
    last_name {Faker::Name.unique.last_name}
    id {Faker::Name.unique.within(range: 1..100_000)}
  end
end
