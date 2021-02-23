FactoryBot.define do
  factory :invoice do
    status { :in_progress }
    customer
  end
end
