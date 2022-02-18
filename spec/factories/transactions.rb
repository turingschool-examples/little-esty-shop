FactoryBot.define do
  factory :transaction do
    invoice
    
    credit_card_number { Faker::IDNumber.valid_south_african_id_number }
    credit_card_expiration { Faker::Date.between(from: '2023-12-31', to: '2030-12-31') }
    result { 0 }
  end
end
