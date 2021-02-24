FactoryBot.define do
  factory :invoice do
    status { [0, 1, 2].sample }
    customer

    factory :invoice_with_customers do
    status { [0, 1, 2].sample }

    transient do
      customer_count { 5 }
    end

      after(:create) do |ic, amount|
        create_list(:customer, amount.customer_count, invoices: [ic])
      end
    end
  end
end
