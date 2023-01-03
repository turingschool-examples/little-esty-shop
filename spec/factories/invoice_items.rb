FactoryBot.define do
  factory :invoice_item do
    quantity {Faker::Number.within(range: 1..200)}
    unit_price {Faker::Number.within(range: 1000..100000)}
    status {[0, 1, 2].sample}
  end
end
