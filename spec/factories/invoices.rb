FactoryBot.define do
  factory :invoice do
    transactions
    invoice_items
    items
    merchants 
    status {}
  end
end
