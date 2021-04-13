FactoryBot.define do
   factory :transcation, class: Transaction do
      cc_number { Faker::Business.credit_card_number }
      cc_expiration_date { Faker::Business.credit_card_expiry_date }
      result { ["failed", "success"].sample }
      association :invoice, factory: :invoice
   end
 end
