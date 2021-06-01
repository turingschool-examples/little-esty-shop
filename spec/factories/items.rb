FactoryBot.define do
  factory :item do
    quanity { rand(1..5) }
    unit_price { rand(100..5000) }
  end
end
