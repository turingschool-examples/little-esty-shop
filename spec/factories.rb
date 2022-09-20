FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end

  factory :item do
    name { Faker::Coffee.blend_name }
    description { Faker::Coffee.notes }
    unit_price { Faker::Number.number(digits: 4) }
    merchant
    enabled { [:true, :false].sample}
  end

  factory :merchant do
    name { Faker::Coffee.origin }
    status {'Enabled'}
  end

  factory :invoiceItem do
    invoice
    item
    quantity { Faker::Number.number(digits: 1) }
    unit_price { Faker::Number.number(digits: 4)}
    status { [:pending, :packaged, :shipped].sample }
  end

  factory :invoice do
    status { ["in progress", "completed", "cancelled"].sample}
    customer
  end
 
  factory :transaction do
    invoice
    credit_card_number { Faker::Number.number(digits: 10).to_s }
    credit_card_expiration_date { Faker::Number.number(digits: 4) }
    result { [:success, :failed].sample }
  end
end