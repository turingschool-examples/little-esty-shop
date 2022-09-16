FactoryBot.define do
  factory :random_item, class: Item do
    name        {Faker::Commerce.product_name}
    description      {Faker::Movie.quote}
    unit_price {Faker::Number.between(from: 1000, to: 98000)}
    association :merchant, factory: :random_merchant
  end
end