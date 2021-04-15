FactoryBot.define do
  factory :invoice do
    status { rand(0..2) }
    customer

    factory :completed_invoice do
      status { "shipped" }
    end
  end
end
