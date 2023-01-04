FactoryBot.define do
  factory :item do
    name {Faker::Name.name}
    unit_price {Faker::Number.within(range: 1000..100000)}
    description {Faker::Quote.famous_last_words}
  end
end
