FactoryBot.define do
  factory :item do
    name {Faker::Lorem.sentence(word_count: 2)}
    description {Faker::Books::Dune.quote}
    unit_price {Faker::Number.number(digits: 5)}
    merchant_id {Faker::Number.within(range: 1..100)}
  end
end
