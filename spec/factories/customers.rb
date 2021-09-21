FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.unique }
    last_name { Faker::Name.unique }
  end
end
