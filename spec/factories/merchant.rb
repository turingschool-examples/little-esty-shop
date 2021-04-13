FactoryBot.define do
   factory :merchant, class: Merchant do
      name { Faker::Name.name }
   end
 end
