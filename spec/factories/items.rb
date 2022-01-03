FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Default Item Name #{n}" }
    description { "Default Description" }
    sequence(:unit_price) { |n| 10000 + (n * 1000) }
    merchant

    factory :item_with_invoices do

      transient do
        invoice_count {2}
      end

      after(:create) do |item, evaluator|
        evaluator.invoice_count.times do
          invoice = create(:invoice)
          invoice_item = create(:invoice_item, invoice: invoice, item: item)
        end
      end
    end
  end
end
