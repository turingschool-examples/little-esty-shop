FactoryBot.define do
  factory :customer, class: Customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    created_at { "2019-02-27 10:52:09 UTC" }
    updated_at { "2020-03-27 14:32:09 UTC" }
  end
end
