require "faker"
FactoryBot.define do
  factory :invoice_item do
    quantity { 10 }
    unit_price {200}
  end
end
