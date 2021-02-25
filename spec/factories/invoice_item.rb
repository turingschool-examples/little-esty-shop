require "faker"
FactoryBot.define do
  factory :invoice_item do
    quantity { 10 }
  end
end
