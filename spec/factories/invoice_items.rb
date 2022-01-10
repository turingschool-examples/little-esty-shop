FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    sequence(:quantity) { |n| 5 + n }
    sequence(:unit_price) { |n| 10000 + (n * 1000) }
    status { 0 }    
  end
end
