FactoryBot.define do
   factory :item, class: Item do
      name { Faker::Vehicle.make }
      description { Faker::GreekPhilosophers.quote }
      unit_price { Faker::Number.between(from: 3000, to: 100000) }
      association :merchant, factory: :merchant
   end
 end
