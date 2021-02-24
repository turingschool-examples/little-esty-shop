FactoryBot.define do
  factory :merchant do
    name {Faker::Bank.name}
  end
end
