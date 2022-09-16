FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end

  # factory :invoice do
  #   status {"completed"}
  #   customer_id {}
  # end
  #
  factory :invoice do
    status {["in progress", "completed", "cancelled"].sample}
    customer
  end

  factory :transaction do
    invoice_id { Faker::Number.number(digits: 3) }
    credit_card_number { Faker::Number.number(digits: 10) }
    credit_card_expiration_date { Faker::Number.number(digits: 4) }
    result { [:success, :failure].sample }
  end

end
