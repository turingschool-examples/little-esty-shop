FactoryBot.define do

  factory :invoice_item do
    item
    invoice
    qantity {rand(1..500)}
    unit_price { rand(100..15000) }
    status { rand(3) }
  end

  factory :transaction do
    invoice
    credit_card_number { rand(1000000000000000..9999999999999999) }
    result { rand(2) }
  end

  factory :invoice do
    customer
    status { rand(3) }
  end

  factory :item do 
    merchant
    sequence(:name){ |n| "Item #{n}"}
    description {"test item description"}
    unit_price { rand(100..15000) }
  end

  factory :custoemr do
    sequence(:first_name) {|n| "Firstname#{n}"}
    sequence(:last_name) {|n| "Lastname#{n}"}
  end

  factory :merchant do
    sequence(:name){ |n| "Merchant #{n}" }
  end
  
end