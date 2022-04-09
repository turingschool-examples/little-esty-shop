FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name }
    description { Faker::Quote.yoda }
    unit_price { Faker::Number.between(from: 1, to: 10) }
    enabled { 1 }
    merchant { nil }
  end
end
