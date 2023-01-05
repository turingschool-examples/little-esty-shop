FactoryBot.define do
  factory :transaction do
    association :invoice
  end
end
