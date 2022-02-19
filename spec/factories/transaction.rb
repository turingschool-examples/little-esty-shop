FactoryBot.define do
  factory :transaction, class: Transaction do
    result { "success" } # What should we pass? "Success" 
    sequence(:credit_card_number) { |n| "1234#{n}6789#{n}" } # How do we generate random? Faker?
    credit_card_expiration_date { nil } 
    invoice
  end
end
