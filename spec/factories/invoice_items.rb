require 'faker'
valid_status = ["Pending", "Packaged", "Shipped"]

FactoryBot.define do
  factory :invoice_item do
    quantity { rand(150) }
    unit_price { rand(50..20000)}
    status { valid_status.sample }
    invoice
    item
  end
end 