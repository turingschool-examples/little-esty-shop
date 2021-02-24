FactoryBot.define do
  factory :item do
    name {Faker::Commerce.material}
    description {Faker::String.random}
    unit_price {Faker::Number.decimal(l_digits: 2)}
  end
end
