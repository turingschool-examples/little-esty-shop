FactoryBot.define do
  factory :invoice_item do
    quantity {Faker::Number.number(digits: 2)}
    unit_price {Faker::Number.number(digits: 2)}
    status { "pending" }
    association :invoice, :item
    trait :shipped do 
      status {"shipped"}
    end

    trait :packaged do 
      status {"packaged"}
    end

    factory :shipped_invoice_items, traits: [:shipped]
    factory :packaged_invoice_items, traits: [:packaged]
  end
end
