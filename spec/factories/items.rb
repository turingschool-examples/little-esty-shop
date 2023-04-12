FactoryBot.define do
  factory :item do
    name { Faker::Cannabis.strain }
    description { Faker::Fantasy::Tolkein.poem }
    unit_price { rand(1000..100000) }
  end
end