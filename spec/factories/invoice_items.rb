FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    status {[0, 1, 2].sample}
    id {Faker::Number.unique.within(range: 1..1_000_000)}
  end
end
