FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "merch_#{n}" }

    factory :merch_w_all do
      transient do
        customer_count { 6 }
        invoice_status { 2 }
        invoice_count { 1 }
      end

      after(:create) do |merchant, evaluator|
        count = evaluator.invoice_count
        evaluator.customer_count.times do
          item = create(:item, merchant: merchant)
          customer = create(:customer)
          count.times do
            invoice = create(:invoice, customer: customer, status: evaluator.invoice_status)
            transaction = create(:transaction, invoice: invoice)
            invoice_item = create(:invoice_item, item: item, invoice: invoice)
            merchant.reload
            customer.reload
            transaction.reload
            item.reload
            invoice.reload
            invoice_item.reload
          end
          count += 1
        end
      end
    end
  end
end
