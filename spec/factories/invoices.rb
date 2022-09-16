FactoryBot.define do
  factory :random_invoice, class: Invoice do
    status {Faker::Number.between(from: 0, to: 2)}        
 
    association :customer, factory: :random_customer
  end
end