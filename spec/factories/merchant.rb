FactoryBot.define do
  factory :merchant, class: Merchant do
    sequence(:name) { |n| "Merchant #{n}" }
  end
end
