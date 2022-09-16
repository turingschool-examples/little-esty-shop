FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end

  factory :invoice do
    status {"in progress" || "completed" || "cancelled"}
    customer
  end
end
