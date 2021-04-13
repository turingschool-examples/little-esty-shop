FactoryBot.define do
   factory :invoice, class: Invoice do
      status { ["cancelled", "in progress", "completed"].sample }
      association :customer, factory: :customer
   end
 end
