FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.decimal_part(digits: 2) }
    sequence(:unit_price) { |n| n + 150 }
    status { Faker::Number.between(from: 0, to: 2) #=> 7 }
    invoice
    item
  end
end