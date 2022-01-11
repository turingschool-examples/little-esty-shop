FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Default Item Name #{n}" }
    description { "Default Description" }
    sequence(:unit_price) { |n| 10000 + (n * 1000) }
    status { 0 }
    merchant

    factory :item_with_invoices do

      transient do
        invoice_count {1}
        invoices {create_list(:invoice, invoice_count)}
        invoice_item_unit_price {15000}
        invoice_item_quantity {8}
        invoice_item_status {0}
      end

      after(:create) do |item, evaluator|
        evaluator.invoice_count.times do |index|
          invoice_item = create(:invoice_item,
          invoice: evaluator.invoices[index],
          item: item,
          unit_price: evaluator.invoice_item_unit_price,
          status: evaluator.invoice_item_status,
          quantity: evaluator.invoice_item_quantity)
        end
        item.reload
      end
    end

    factory :item_with_transactions do
      transient do
        transaction_count {1}
        customer {create(:customer)}
        invoice_item_quantity {4}
        invoice_item_unit_price {15000}
        transaction_result {0}
        invoice {create(:invoice, customer: customer)}
      end
      after(:create) do |item, evaluator|
        evaluator.transaction_count.times do
          invoice_item = create(:invoice_item, item: item, invoice: evaluator.invoice, quantity: evaluator.invoice_item_quantity, unit_price: evaluator.invoice_item_unit_price)
          transaction = create(:transaction, result: evaluator.transaction_result, invoice: evaluator.invoice)
        end
      end
    end
  end
end
