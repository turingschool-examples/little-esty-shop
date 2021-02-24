FactoryBot.define do
  factory :transaction do
    sequence(:credit_card_number, 1000_0000_0000_0000 ) { |n| n + 12 }
    credit_card_expiration_date { nil }
    result { ["success", "failure"].sample }
    invoice
  end
end
