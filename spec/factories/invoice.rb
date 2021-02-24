FactoryBot.define do
  factory :invoice do
    status {Faker::Number.within(range: 0..2)}
  end
end
