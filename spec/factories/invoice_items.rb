FactoryBot.define do
  factory :invoice_item do
    quantity { 1 }
    unit_price { 1 }
    status { 1 }
    item { nil }
    invoice { nil }
  end
end
