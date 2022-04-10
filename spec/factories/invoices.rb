FactoryBot.define do
  factory :invoice do
    association :customer
    status {[0, 1, 2].sample}
    id {Faker::Number.unique.within(range: 1..100_000)}
  end
end
