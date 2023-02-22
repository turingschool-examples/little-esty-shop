FactoryBot.define do
  factory :item do
    name { Faker::Game.title }
    description { "A video game!" }
    unit_price { Faker::Number.between(from: 30, to: 250) }
  end
end

# FOREIGN KEY = merchant_id