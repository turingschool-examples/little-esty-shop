#creating relationships with factorybot
FactoryBot.define do 
  factory :invoice_item do 
    quantity { 6 }
    unit_price { 1300 }
    status { 1 }
    item # automatically creates an item for invoice_item
    invoice # automatically creates an invoice for invoice_item
  end
end