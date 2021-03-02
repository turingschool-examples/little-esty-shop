FactoryBot.define do
  factory :item do
    name {Faker::Commerce.product_name}
    description {Faker::Name.name}
    unit_price {Faker::Number.decimal(l_digits: 2)}
  end
end
