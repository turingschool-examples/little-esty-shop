FactoryBot.define do
  factory :transaction, class: Transaction do
    credit_card_number { 123456789 }
    credit_card_expiration_date { '' }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
  end
end
