FactoryBot.define do
  factory :invoice do
    customer_id { Faker::Number.between(from: 1, to: 174)}
    status { 1 }
    association :customer
    
    trait :completed do 
      status { 2 }
    end 

    trait :cancelled do 
      status { 0 }
    end

    factory :completed_invoice, traits: [:completed]
    factory :cancelled_invoice, traits: [:cancelled]
  end
end
