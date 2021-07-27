FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}"}
    sequence(:description) { |n| "Description for item #{n}"}
    sequence(:unit_price) { |n| n + 150 }
    merchant
  end
end
