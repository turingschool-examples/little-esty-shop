FactoryBot.define do
  factory :item do
    sequence(:name) {|n| "name #{n}"}
    sequence(:description) {|n| "description #{n}"}
    sequence(:unit_price) { |n| n + 2.50 }
    merchant

    factory :item_with_merchant do
      sequence(:name) {|n| "name #{n}"}
      sequence(:description) {|n| "description #{n}"}
      sequence(:unit_price) { |n| n + 2.50 }

      transient do
        merchant_count { 5 }
      end

      after(:create) do |mc, amount|
        create_list(:merchant, amount.merchant_count, items: [mc])
      end
    end
  end
end
