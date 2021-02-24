FactoryBot.define do
  factory :invoice do
    customer
    status { "MyString" }
  end
end
