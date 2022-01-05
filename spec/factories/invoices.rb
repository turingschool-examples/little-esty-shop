FactoryBot.define do
  factory :invoice do
    trait :in_progress do
      status { 'in_progress' }
    end

    trait :cancelled do
      status { 'cancelled' }
    end

    trait :completed do
      status { 'completed' }
    end
    
    customer
  end
end
