FactoryBot.define do
  factory :item do
    name {Faker::Lorem.sentence(word_count: 3)}
    description {Faker::Lorem.sentence(word_count:17)}
    unit_price {Faker::Number.number(digits: 5)}
    # unit_price {Faker::Number.decimal(l_digits: 3, r_digits: 2)}
    merchant_id {Faker::Number.within(range: 1..100)}
  end
end
