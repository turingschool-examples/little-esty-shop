require "faker"
FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.unique.name }
    last_name { Faker::Name.unique.name }
  end
end
