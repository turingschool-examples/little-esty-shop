FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Default Merchant Name #{n}" }

    factory :merchant_with_invoices do
      transient do
        invoice_count {2}
      end
      after(:create) do |merchant, evaluator|
        evaluator.invoice_count.times do
          item = create(:item, merchant: merchant)
          invoice = create(:invoice)
          invoice_item = create(:invoice_item, item: item, invoice: invoice)
        end
      end
    end

    factory :merchant_with_completed_invoices do
      transient do
        invoice_count {2}
      end
      after(:create) do |merchant, evaluator|
        evaluator.invoice_count.times do
          item = create(:item, merchant: merchant)
          invoice = create(:completed_invoice)
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
  end
end
