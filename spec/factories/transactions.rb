FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { 1 }
    credit_card_expiration_date { "2023-01-03 15:02:58" }
    result { 1 }
  end
end
