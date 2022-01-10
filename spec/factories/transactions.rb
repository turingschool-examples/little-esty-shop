FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| (1234567890123456 + n).to_s }
    credit_card_expiration_date { "2022-01-03" }
    result { 0 }

    factory :transaction_with_customer do
      transient do
        customer {create(:customer)}
      end
      after(:create) do |transaction, evaluator|
        transaction.invoice.update(customer: evaluator.customer)
      end
    end

    factory :transaction_for_item do
      transient do
        customer {create(:customer)}
        item {create(:item)}
        invoice_item_quantity {4}
        invoice_item_unit_price {15000}
      end
      after(:create) do |transaction, evaluator|
        transaction.invoice.update(customer: evaluator.customer)
        create(:invoice_item, item: evaluator.item, invoice: transaction.invoice, quantity: invoice_item_quantity, unit_price: invoice_item_unit_price)
      end
    end
  end
end
