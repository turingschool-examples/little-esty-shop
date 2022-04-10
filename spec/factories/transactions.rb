FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number {Faker::Number.number(digits: 16).to_s}
    result { [0, 1].sample}
    id {Faker::Number.unique.within(range: 1..100_000)}
    created_at { Faker::Date.between(from: '2014-09-23', to: '2015-09-23')}
    updated_at { Faker::Date.between(from: '2016-09-23', to: '2017-09-23')}
  end
end
