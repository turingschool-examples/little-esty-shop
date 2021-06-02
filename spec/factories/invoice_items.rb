FactoryBot.define do
  factory :invoice_item do
    quantity { 1 }
    unit_price { 1 }
    status { "MyString" }
    invoice { nil }
    item { nil }
  end
end
