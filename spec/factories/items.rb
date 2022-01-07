FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Default Item Name #{n}" }
    description { "Default Description" }
    sequence(:unit_price) { |n| 10000 + (n * 1000) }
    merchant

    factory :item_with_invoices do

      transient do
        invoice_count {2}
        invoices {create_list(:invoice, invoice_count)}
        invoice_item_unit_price {15000}
        invoice_item_status {0}
        invoice_quantity {8}
      end

      after(:create) do |item, evaluator|
        evaluator.invoice_count.times do |index|
          invoice_item = create(:invoice_item,
          invoice: evaluator.invoices[index],
          item: item,
          unit_price: evaluator.invoice_item_unit_price,
          status: evaluator.invoice_item_status,
          quantity: evaluator.invoice_quantity)
        end
        item.reload
      end
    end
  end
end
