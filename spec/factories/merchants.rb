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
          invoice_item = (:invoice_item, item: item, invoice: invoice )
        end
      end
    end
  end
end
