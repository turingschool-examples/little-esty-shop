FactoryBot.define do
  factory :discount do
    sequence(:discount) {|n| 10 + (n * 5) }
    sequence(:quantity) { |n| n + 2 }
    merchant
  end
end
