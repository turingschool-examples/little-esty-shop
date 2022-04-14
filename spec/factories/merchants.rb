FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end
end
