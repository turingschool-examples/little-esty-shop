FactoryBot.define do
  factory :customer do
    sequence(:first_name, 0) { |n| "FirstName#{n}" }
    sequence(:last_name, 0) { |n| "LastName#{n}" }

    factory :customer_with_invoice do
      after(:create) do |cust|
        create(:invoice, customer_id: cust.id)
      end
    end
  end
end