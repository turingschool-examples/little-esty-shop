FactoryBot.define do
  factory :merchant do
    status { Faker::Company.name }
  end
end
