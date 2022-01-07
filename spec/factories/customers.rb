FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "Default First Name #{n}" }
    sequence(:last_name) { |n| "Default Last Name #{n}" }

    factory :customer_with_invoices do

      transient do
        invoice_count {2}
      end

      after(:create) do |customer, evaluator|
        create_list(:invoice, evaluator.invoice_count, customer: customer)
      end
    end

    factory :customer_with_transactions do
      transient do
        transaction_count {2}
        merchant {create(:merchant)}
        transaction_status {0}
      end

      after(:create) do |customer, evaluator|
        evaluator.transaction_count.times do
          item = create(:item, merchant: merchant)
          invoice = create(:invoice, customer: customer)
          invoice_item = create(:invoice_item, item: item, invoice: invoice)
          transaction = create(:transaction, status: evaluator.transaction_status, invoice: invoice)
        end
      end 
    end
  end
end
