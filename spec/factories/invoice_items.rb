FactoryBot.define do
  factory :invoice_item do
    quanity { 1 }
    unit_price { "" }
    status { 1 }
    item { nil }
    invoice { nil }
  end
end
