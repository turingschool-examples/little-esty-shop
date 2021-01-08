FactoryBot.define do
    factory :merchant do
        name { Faker::Company.name }
    end
    
    factory :customer do
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
    end

    factory :invoice do
        status { [0, 1, 2].sample }
    end

    factory :transaction do
        invoice
        credit_card_number { Faker::Number.number(digits: 16).to_s }
        credit_card_expiration_date { Faker::Date.between(from: Date.today, to: 1.year.from_now) }
        result { [0, 1].sample }
    end    
    
end
