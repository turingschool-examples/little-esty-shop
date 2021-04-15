
FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { rand(0..1) }
    invoice 
  end
end
