FactoryBot.define do
  factory :invoice do
    status { ['in progress','completed', 'cancelled'].sample }
    customer { nil }
  end
end
