FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "Default First Name #{n}" }
    sequence(:last_name) { |n| "Default Last Name #{n}" }

    factory :customer_with_invoices do

      transient do
        invoice_count {2}
      end

      after(:create) do |customer, evaluator|
        create_list(:invoice, evaluator.invoice_count, customer: customer)
      end
    end
  end
end
