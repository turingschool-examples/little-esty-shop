FactoryBot.define do
  factory :invoice_item do
    item_id {Faker::Number.within(range: 100..9999)}
    invoice_id {Faker::Number.within(range: 1..999)}
    quantity {Faker::Number.within(range: 1..99)}
    unit_price {Faker::Number.within(range: 1000..99999)}
    status { [0, 1, 2].shuffle.first }
  end
end
