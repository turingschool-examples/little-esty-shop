FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| (1234567890123456 + n).to_s }
    credit_card_expiration_date { "2022-01-03" }
    result { 0 }
  end
end
