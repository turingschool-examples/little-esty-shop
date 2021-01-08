FactoryBot.define do
    factory :merchant do
        name { Faker::Company.name }
    end
    
    factory :customer do
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
    end

    factory :invoice do
        status { Faker::Number.between(from: 0, to: 2) }
    end

    factory :transaction do
        credit_card_number { Faker::Number.number(digits: 16) }
        credit_card_expiration_date { Faker::Date.between(from: Date.today, to: 1.year.from_now) }
        result { Faker::Number.between(from: 0, to: 1) }
        invoice
    end    
    
end
