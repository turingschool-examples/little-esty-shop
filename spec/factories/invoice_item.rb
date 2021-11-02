FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    association :item
    association :invoice

    quantity { Faker::Number.within(range: 1..1000)  }
    unit_price { Faker::Number.within(range: 1..100000)  }
    status { ["packaged", "shipped", "pending"].sample }
    id { Faker::Number.unique.within(range: 1..1000000) }
  end
end
