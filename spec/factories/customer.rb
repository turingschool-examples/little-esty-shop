FactoryBot.define do
  factory :customer, class: Customer do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    id { Faker::Number.unique.within(range: 1..100) }
  end
end
