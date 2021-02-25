require "faker"

FactoryBot.define do
  factory :item do
    name { Faker::Name.unique.name }
    description { "Best #1"}
    unit_price { 10 }
  end
end
