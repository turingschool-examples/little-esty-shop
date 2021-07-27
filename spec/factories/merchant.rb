FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    enabled { true }
  end
end
