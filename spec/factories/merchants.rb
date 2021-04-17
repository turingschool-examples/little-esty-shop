FactoryBot.define do
  status = [ 0, 1 ]
  factory :merchant do
    name { Faker::Company.name }
    merchant_status { status.sample }
  end
end
