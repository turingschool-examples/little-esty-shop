FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| (1234567890123456 + n).to_s }
    credit_card_expiration_date { "2022-01-03" }
    result { 0 }

    factory :transaction_with_customer do
      transient do
        customer {create(:customer)}
      end
      after(:create) do |transaction, invoice, evaluator|
        invoice.update(customer: evaluator.customer)
      end
    end
  end
end
