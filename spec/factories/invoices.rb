FactoryBot.define do
  factory :invoice do
    customer
    status { Invoice.statuses.keys.sample }
    created_at { Faker::Time.between(from: 2.years.ago, to: Time.now) }
    updated_at { created_at }

    trait :with_transactions do
      transient do
        transactions_count { 3 }
      end

      after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transactions_count, invoice: invoice)
      end
    end

    trait :with_invoice_items do
      transient do
        invoice_items_count { 5 }
      end

      after(:create) do |invoice, evaluator|
        create_list(:invoice_item, evaluator.invoice_items_count, invoice: invoice)
      end
    end
  end
end
