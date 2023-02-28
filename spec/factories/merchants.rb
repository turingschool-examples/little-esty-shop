FactoryBot.define do
  factory :merchant do
    name {Faker::Lorem.words(number: 3)}
  end
end
