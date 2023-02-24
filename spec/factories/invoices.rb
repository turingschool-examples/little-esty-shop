FactoryBot.define do
  factory :invoice do
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
