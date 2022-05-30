# see notes below for creating relationships with factorybot
FactoryBot.define do
  factory :invoice_item do
    possible_status = [0, 1, 2]
    quantity { Faker::Number.between(from: 1, to: 20)  }
    unit_price { Faker::Number.number(digits: 4) }
    status { possible_status.sample }
    item # automatically creates an item for invoice_item
    invoice # automatically creates an invoice for invoice_item
  end
end
