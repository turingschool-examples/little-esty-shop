FactoryBot.define do
  factory :invoice do
    customer
    status { :cancelled }
  end
end
