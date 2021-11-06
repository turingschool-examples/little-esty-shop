FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Stripe.valid_card.to_s }
    credit_card_expiration_date { nil }
    result { ['success', 'failed'].sample }
    invoice
  end
end
