FactoryBot.define do
  factory :transaction do
    credit_card_number { "MyString" }
    credit_card_expiration_date { 1 }
    result { 1 }
    invoice { nil }
  end
end
