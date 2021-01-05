FactoryBot.define do
  factory :invoice do
    status { 1 }
    Customer { nil }
    Merchant { nil }
  end
end
