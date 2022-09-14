valid_status = ["In Progress", "Completed", "Cancelled"]

FactoryBot.define do
  factory :invoice do
    status { valid_status.sample }
    customer
  end
end 