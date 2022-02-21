FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Device.model_name }
    description { Faker::Device.manufacturer }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
