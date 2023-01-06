FactoryBot.define do
  factory :invoice_item do
    association :invoice
    association :item
  end
end
