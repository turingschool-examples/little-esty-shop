FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Company.name }
  end
end
