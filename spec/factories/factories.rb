FactoryBot.define do
  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
  end

  factory :item do
    name {Faker::Name.name}
    merchant_id {1}
    description {Faker::Lorem.words(number: 4)}
    unit_price{Faker::Number.number(digits: 5)}
  end

  factory :merchant do
    name {Faker::Name.name}
  end

  factory :invoice do
    # status {Faker::Number.between(from: 1, to:3)}
  end

  factory :invoice_item do
    quantity {Faker::Number.number(digits: 3)}
    unit_price {Faker::Number.number(digits: 4)}
    status {Faker::Number.between(from: 1, to:3)}
  end

  factory :transaction do
    credit_card_number {Faker::Number.number(digits: 16)}
  end

  # it "tests factorybot" do
  #   @dummy = FactoryBot.create(:merchant)
  # end
end