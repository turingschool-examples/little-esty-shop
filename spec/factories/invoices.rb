require 'faker'
FactoryBot.define do
  factory :invoice do
    association :customer, factory: :customer
    status { [0, 1, 2].sample }
  end
end
