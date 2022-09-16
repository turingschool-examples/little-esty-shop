FactoryBot.define do
  factory :random_merchant, class: Merchant do
    name        {Faker::Commmerce.product_name}
  end
end