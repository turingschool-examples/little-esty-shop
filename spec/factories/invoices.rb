FactoryBot.define do
  factory :invoice do
    customer
    status { 0 }

    trait :completed do
      status { 2 }
    end

    factory :invoice_with_transactions do
      transient do
        transaction_count {2}
        transaction_result {0}
      end
      after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transaction_count, invoice: invoice, result: evaluator.transaction_result)
      end
    end

    factory :completed_invoice, traits:[:completed]
  end
end
