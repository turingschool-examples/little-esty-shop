FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity)
    sequence(:unit_price)
    
    trait :pending do
      status { 'pending' }
    end

    trait :packaged do
      status { 'packaged' }
    end

    trait :shipped do
      status { 'shipped' }
    end

    item
    invoice
  end
end
