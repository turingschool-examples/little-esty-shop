FactoryBot.define do
  factory :invoice do
    possible_status = [0, 1, 2]
    status { possible_status.sample }
    customer
  end
end
