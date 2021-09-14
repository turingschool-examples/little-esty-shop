FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Company.unique.name }
    id { Faker::Number.unique.within(range: 1..100) }
  end
end
