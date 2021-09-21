FactoryBot.define do
  factory :invoice do
    customer_id { Faker::Number.between(from: 1,to: 20 )}
    status { "completed"}
  end
end
