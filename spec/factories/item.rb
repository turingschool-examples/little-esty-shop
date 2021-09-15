FactoryBot.define do
  factory :item, class: Item do
    name { Faker::JapaneseMedia::StudioGhibli. }
    description { Faker::JapaneseMedia::StudioGhibli. }
    unit_price { 5 }
    created_at { "2019-02-27 10:52:09 UTC" }
    updated_at { "2020-03-27 14:32:09 UTC" }
  end
end
