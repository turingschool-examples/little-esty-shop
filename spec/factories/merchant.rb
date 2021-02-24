require "faker"

FactoryBot.define do
  factory :merchant do
    name { Faker::Name.unique.name }
  end
end
