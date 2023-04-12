FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { Faker::Time.between(from: 2.years.ago, to: Time.now) }
    updated_at { created_at }

    trait :with_invoices do
      transient do
        invoices_count { 5 }
      end

      after(:create) do |customer, evaluator|
        create_list(:invoice, evaluator.invoices_count, customer: customer)
      end
    end
  end
end