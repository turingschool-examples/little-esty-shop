FactoryBot.define do
  factory :invoice do
    customer
    status { 0 }

    trait :completed do
      status { 2 }
    end

    factory :completed_invoice, traits:[:completed]
  end
end
