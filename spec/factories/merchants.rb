FactoryBot.define do
  factory :merchant do
    sequence(:name, 0) { |n| "Merchant#{n}"}
  end
end
