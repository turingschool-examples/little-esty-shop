FactoryBot.define do
    factory :merchant do
        name { Faker::Company.name }
    end

    factory :customer do
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
    end

    factory :invoice do
      customer
      merchant
      status { [0, 1, 2].sample }
    end

    factory :transaction do
        invoice
        credit_card_number { Faker::Number.number(digits: 16).to_s }
        credit_card_expiration_date { Faker::Date.between(from: Date.today, to: 1.year.from_now) }
        result { [0, 1].sample }
    end

    factory :item do
      merchant
      name { Faker::Name.name }
      description { Faker::Lorem.sentence }
      unit_price { Faker::Number.number(digits: 3) }
    end

    factory :invoice_item do
      invoice
      item
      quantity { Faker::Number.number(digits: 4) }
      unit_price { Faker::Number.number(digits: 6) }
      status { [0, 1, 2].sample }
    end
end
