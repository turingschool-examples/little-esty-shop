FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "item_#{n}" }
    sequence(:description) { |n| "desc_#{n}" }
    sequence(:unit_price)
    merchant

    factory :with_invoices do
      transient do
        invoice_count { 6 }
      end

      after(:create) do |item, evaluator|
        create_list(:invoice, evaluator.invoice_count, items: item)
        item.reload
      end
    end
  end
end
