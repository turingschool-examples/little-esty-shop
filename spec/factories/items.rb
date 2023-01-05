FactoryBot.define do
  factory :item do
    sequence(:name, 0) { |n| "Item#{n}" }
    association :merchant
  end
end
