FactoryBot.define do
  factory :invoice do
    association :customer
  end
end
