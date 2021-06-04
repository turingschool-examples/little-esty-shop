FactoryBot.define do
  factory :merchant do
    name { Faker::Name.first_name }
  end
end
