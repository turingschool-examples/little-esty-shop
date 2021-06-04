FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Stripe.valid_card }
    credit_card_expiration_date { "#{Faker::Stripe.month}/#{Faker::Stripe.year}" }
    result { rand(0..2) }
    invoice { nil }
  end
end
