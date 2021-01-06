FactoryBot.define do 
  factory :item, class: Item do 
    name { Faker::Commerce.product_name }
    description { Faker::Quote.famous_last_words }
    unit_price { Faker::Number.between(from: 1, to: 100) }
    association :merchant
  end
end