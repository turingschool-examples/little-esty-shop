FactoryBot.define do
  factory :merchant do
    name {Faker::Commerce.brand}
  end
end
