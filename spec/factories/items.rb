FactoryBot.define do
  factory :item do
    name { Faker::Name.unique}
    description { Faker::Hacker.say_something_smart }
    unit_price { Faker::Number.digits(5) }
    merchant_id { Faker::Number.between(from: 1, to: 20)}
  end
end