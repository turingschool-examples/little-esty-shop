FactoryBot.define do
  factory :invoice do
    customer 
    status { "Pending" }
  end
end
