FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.number(digits: 2) }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    status { [0,1,2].sample }
  end
end
