FactoryBot.define do
  factory :merchant do
    name { Faker::Name.unique }
  end
end
