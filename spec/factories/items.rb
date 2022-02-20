FactoryBot.define do
  factory :item do
    invoice_items
    invoices through invoice items
    name { }
    description { }
    unit_price { }
  end
end
