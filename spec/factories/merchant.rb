FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Name.name  }
    created_at { "2019-02-27 10:52:09 UTC" }
    updated_at { "2020-03-27 14:32:09 UTC" }
  end
end
