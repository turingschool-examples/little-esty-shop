FactoryBot.define do
  factory :invoice do
    association :customer
    status {[0, 1, 2].sample}
    id {Faker::Number.unique.within(range: 1..100_000)}
    created_at { Faker::Date.between(from: '2014-09-23', to: '2015-09-23')}
    updated_at { Faker::Date.between(from: '2016-09-23', to: '2017-09-23')}
  end
end
