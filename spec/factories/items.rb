FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.between(from: 100, to: 1000) }
    created_at { Faker::Time.between(from: 2.years.ago, to: Time.now) }
    updated_at { created_at }
  end
end