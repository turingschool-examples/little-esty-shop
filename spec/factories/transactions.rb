FactoryBot.define do 
  factory :transaction, class: Transaction do 
    association :invoice
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date {}
    result {["success", "failed"].sample}
  end
end