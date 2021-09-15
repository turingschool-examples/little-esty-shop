FactoryBot.define do
  factory :transaction, class: Transaction do
    credit_card_number { 1234567890123456 }
    credit_card_expiration_date { '' }
    created_at { "2019-02-27 10:52:09 UTC" }
    updated_at { "2020-03-27 14:32:09 UTC" }
  end
end
