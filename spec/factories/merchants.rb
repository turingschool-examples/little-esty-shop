FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Default Merchant Name #{n}" }
    status { 0 }

    factory :merchant_with_invoices do
      transient do
        invoice_count {2}
        customer {create(:customer)}
        invoice_status {0}
      end
      after(:create) do |merchant, evaluator|
        evaluator.invoice_count.times do
          item = create(:item, merchant: merchant)
          invoice = create(:invoice, status: evaluator.invoice_status, customer: evaluator.customer)
          invoice_item = create(:invoice_item, item: item, invoice: invoice)
        end
      end
    end

    factory :merchant_with_items do
      transient do
        item_count {2}
      end
      after(:create) do |merchant, evaluator|
        create_list(:item, evaluator.item_count, merchant: merchant)
      end
    end

    factory :merchant_with_transactions do
      transient do
        transaction_count {1}
        customer {create(:customer)}
        transaction_result {0}
        invoice_item_unit_price {15000}
        invoice_item_quantity {4}
        invoice {create(:invoice, customer: customer)}
      end
      after(:create) do |merchant, evaluator|
        evaluator.transaction_count.times do
          item = create(:item, merchant: merchant)
          invoice_item = create(:invoice_item, item: item, invoice: evaluator.invoice, unit_price: evaluator.invoice_item_unit_price, quantity: evaluator.invoice_item_quantity)
          transaction = create(:transaction, result: evaluator.transaction_result, invoice: evaluator.invoice)
        end
      end
    end

  end
end
