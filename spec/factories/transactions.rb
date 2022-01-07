FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| (1234567890123456 + n).to_s }
    credit_card_expiration_date { "2022-01-03" }
    result { 0 }

    factory :transactions_with_invoices
      transient do
        invoice_count {5}
        customer {create(:customer)}
      end

    after(:create) do |transaction, evaluator|
      evaluator.invoice_count.times do
        item = create(:item)
        invoice = create(:invoice, customer: evaluator.customer)
        invoice_item = create(:invoice_item, item: item, invoice: invoice)
      end
    end
  end
end
