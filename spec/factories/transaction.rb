FactoryBot.define do
  factory :transaction do
    possible_results = [0, 1]
    credit_card_number{ Faker::Number.number(digits: 16) }
    credit_card_expiration_date { "" }
    result { possible_results.sample }
    invoice
  end
end
