FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Brand }
  end
end
