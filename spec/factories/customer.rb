FactoryBot.define do
  factory :customer, class: Customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    after(:create) do |customer|
     invoice = create(:invoice, customer_id: customer.id)
     create(:transaction, invoice_id: invoice.id)
   end
  end
end
