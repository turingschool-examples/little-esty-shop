require 'faker'
FactoryBot.define do
  factory :invoice do
    association :customer, factory: :customer
    traits_for_enum(:status)
  end
end
