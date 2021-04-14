FactoryBot.define do
   factory :invoice_item, class: InvoiceItem do
      quantity { Faker::Number.between(from: 1, to: 20) }
      unit_price { Faker::Number.between(from: 1000, to: 80000) }
      status { [0, 1, 2].sample }
   end
 end
