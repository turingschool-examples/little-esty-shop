FactoryBot.define do
  factory :invoice_item do
    quanity { rand(0..100) }
    unit_price { rand(100..1000) }
  end
end
