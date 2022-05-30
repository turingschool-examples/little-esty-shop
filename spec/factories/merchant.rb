FactoryBot.define do
  factory :merchant do
    name { [Faker::Food.fruits, Faker::Company.industry].join(" ") }
  end
end
