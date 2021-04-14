
FactoryBot.define do
factory :item, class: Item do
  name { Faker::Coffee.name }
  description { Faker::Lorem.sentence(word_count: 5) }
  unit_price { Faker::Number.number(digits: 5) }
  association :merchant, factory: :merchant
end
end
