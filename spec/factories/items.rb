FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Default Item Name #{n}" }
    description { "Default Description" }
    sequence(:unit_price) { |n| 10000 + (n * 1000) }
    merchant
  end
end
