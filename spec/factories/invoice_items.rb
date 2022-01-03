FactoryBot.define do
  factory :invoice_item do
    items { nil }
    invoices { nil }
    quantity { 1 }
    unit_price { 1 }
    status { 1 }
  end
end
