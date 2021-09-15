FactoryBot.define do
  factory :invoice_item do
    quantity    { 10 }
    unit_price  { 12345 }
    status      { 0 }
    item
    invoice
  end
end
