FactoryBot.define do
  factory :invoice do
    status { [0, 1, 2].sample }
    # cancelled: 0, completed: 1, in progress: 2
    customer
  end
end
