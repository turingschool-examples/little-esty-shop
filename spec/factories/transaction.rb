FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Commerce.product_name }
    credit_card_expiration_date { 0 }
    result {["success", "failed"].sample}
    invoice
  end
end
