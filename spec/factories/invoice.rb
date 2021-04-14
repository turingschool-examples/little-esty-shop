FactoryBot.define do
   factory :invoice, class: Invoice do
      status { [0, 1, 2].sample }
      association :customer, factory: :customer
   end
 end
