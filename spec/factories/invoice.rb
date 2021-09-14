FactoryBot.define do
  factory :invoice, class: Invoice do
    association :customer
    status { ["cancelled", "completed", "in progress"].sample }
    id { Faker::Number.unique.within(range: 1..100) }
  end
end
