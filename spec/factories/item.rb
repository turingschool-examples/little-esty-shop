FactoryBot.define do
  factory :item do
    sequence(:name) {|n| "name #{n}"}
    sequence(:description) {|n| "description #{n}"}
    sequence(:unit_price) { |n| n + 2.50 }
    merchant
  end
end
