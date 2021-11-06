FactoryBot.define do
  factory :invoice do
    status { ['cancelled', 'completed', 'in progress'].sample }
    customer
  end
end
