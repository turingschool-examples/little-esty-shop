FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    unit_price { rand(100..1000) }
  end
end
