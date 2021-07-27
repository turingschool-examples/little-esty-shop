FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Merchant #{n}"}
  end
end
