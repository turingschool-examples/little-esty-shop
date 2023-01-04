FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { 1 }
    unit_price { 1 }
    status { 1 }
  end
end
