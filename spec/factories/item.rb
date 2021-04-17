FactoryBot.define do
   factory :item, class: Item do
     sequence :name do |n|
       "Item #{n}"
     end
     description { Faker::GreekPhilosophers.quote }
     unit_price { Faker::Number.between(from: 3000, to: 100000) }
     enabled { Faker::Boolean.boolean }

     merchant
   end
 end
