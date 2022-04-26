FactoryBot.define do
  factory :bulk_discount do
    percentage_discount { Faker::Number.between(from: 1, to: 99) }
    quantity_threshold { Faker::Number.between(from: 1, to: 5) }
    merchant { nil }
  end
end