FactoryBot.define do
  factory :invoice do
    transient do
      invoice_item_status { nil }
    end

    association :customer

    factory :invoice_with_invoice_item do
      after(:create) do |invoice, evaluator|
        create(:invoice_item, invoice_id: invoice.id, status: evaluator.invoice_item_status)
      end
    end
  end
end
