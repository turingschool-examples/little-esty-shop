require "faker"

FactoryBot.define do
  factory :item do
    name { Faker::Name.unique.name }
  end
end
