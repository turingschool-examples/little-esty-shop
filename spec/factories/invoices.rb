FactoryBot.define do
  factory :invoice do
    customer_id {Faker::Number.within(range: 1..174)}
    status { [0, 1, 2].shuffle.first }
  end
end
