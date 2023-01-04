FactoryBot.define do
  factory :item do
    name {Faker::Food.dish}
    unit_price {Faker::Number.within(range: 1000..100000)}
    description {Faker::Quote.famous_last_words}
  end
end
