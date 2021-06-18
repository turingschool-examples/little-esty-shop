FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    unit_price { "" }
    merchant { nil }
  end
end
