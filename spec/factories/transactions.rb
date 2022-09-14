require 'faker'
valid_results = ["Success", "Failed"]

FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Bank.account_number(digits: 16) }
    result { valid_results.sample }
    invoice
  end
end 