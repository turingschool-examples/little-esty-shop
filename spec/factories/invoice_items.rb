FactoryBot.define do
  factory :invoice_item do
    quanity { Faker::Number.number }
    unit_price { rand(100..5000) }
  end
end