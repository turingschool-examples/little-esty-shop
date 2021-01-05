FactoryBot.define do
  factory :transaction do
    credit_card_number { 1 }
    credit_card_expiration_date { "2021-01-03" }
    result { 1 }
  end
end
