FactoryBot.define do
  factory :transaction do
    sequence(:credit_card_number) { |n| n.to_s.rjust(16, '0') }
    sequence(:credit_card_expiration_date) { |n| (rand(n)+1).years.from_now }
    
    trait :nil do
      result { 0 }
    end

    trait :failed do
      result { 1 }
    end

    trait :success do
      result { 2 }
    end

    invoice
  end
end
