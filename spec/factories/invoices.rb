FactoryBot.define do
  factory :invoice do
    customer_id { nil }
    status { 1 }
  end
end
