FactoryBot.define do
  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
  end

  factory :item do
    name {Faker::Commerce.product_name}
    description {Faker::Lorem.words(number: 4)}
    unit_price{Faker::Number.within(range: 100..20000)}
  end

  factory :merchant do
    name {Faker::Company.name}
  end

  factory :invoice do
    status {["In Progress", "Completed", "Cancelled"].sample}
  end

  factory :invoice_item do
    quantity {Faker::Number.number(digits: 3)}
    unit_price {Faker::Number.within(range: 100..20000)}
    status {["Pending", "Packaged", "Shipped"].sample}
  end

  factory :transaction do
    credit_card_number {Faker::Number.number(digits: 16)}
    result {Faker::Boolean.boolean}
  end
end
