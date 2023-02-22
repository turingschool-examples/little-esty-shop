FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card(:visa) }
    credit_card_expiration_date { "2024-6-9" } # nil in csv file?
    result { Faker::Number.between(from: 0, to: 1) }
  end
end

# FOREIGN KEY = invoice_id
# For credit card numbers, Faker::Finance.credit_card(:visa) will generate 16 digits with a dash like "4448-8934-1277-7195"
# If the dashes cause problems, replace with Faker::Number.number(digits: 16) 
# All cards in csv are 16 digits. Removing (:visa) will generate other card types like "3018-348979-1853"
