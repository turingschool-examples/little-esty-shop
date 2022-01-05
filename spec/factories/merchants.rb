FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "merch_#{n}" }

    factory :merch_w_all do
      transient do
        item_invoice_count { 10 }
      end

      after(:create) do |merchant, evaluator|
        evaluator.item_invoice_count.times do
          item = create(:item, merchant: merchant)
          invoice = create(:invoice)
          transaction = create(:transaction, invoice: invoice)
          invoice_item = create(:invoice_item, item: item, invoice: invoice)
          merchant.reload
          item.reload
          invoice.reload
          invoice_item.reload
        end
      end
    end
  end
end
