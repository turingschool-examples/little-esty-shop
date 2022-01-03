FactoryBot.define do
  factory :transaction do
    invoices { nil }
    credit_card_number { 1 }
    credit_card_expiration_date { "2022-01-03" }
    result { 1 }
  end
end
