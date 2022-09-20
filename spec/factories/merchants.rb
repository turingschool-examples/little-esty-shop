FactoryBot.define do
  factory :random_merchant, class: Merchant do
    name        {Faker::Name.name}
  end
end