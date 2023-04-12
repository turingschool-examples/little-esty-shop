FactoryBot.define do
    factory :item do
      name { Faker::Fantasy::Tolkien.character}
      description { Faker::Quote.yoda }
      unit_price { Faker::Alphanumeric.alpha(number: 10) }
      merchant
    end
end

