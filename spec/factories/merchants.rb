FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Default Merchant Name #{n}" }
  end
end
