FactoryBot.define do
  factory :item do
    name { Faker::GreekPhilosophers.name }
    description { Faker::ChuckNorris.fact }
    unit_price { Faker::Number.within(range: 1..10000) }
    merchant
  end
end
