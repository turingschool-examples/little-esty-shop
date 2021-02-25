require "faker"
FactoryBot.define do
  factory :transaction do
  credit_card_number {Faker::Business.credit_card_number.to_s}
  end
end
