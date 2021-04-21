FactoryBot.define do
  factory :invoice do
    status{[0, 1, 2].sample} #this can be hardcoded into the tests
    customer
    transaction
  end
end
