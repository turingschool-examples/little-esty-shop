require 'faker'
FactoryBot.define do
  factory :invoice do
    association :customer, factory: :customer
  end
end
