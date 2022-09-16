FactoryBot.define do
  factory :random_merchant, class: Merchant do
    name        {Faker::Commerce.product_name}
  end
end