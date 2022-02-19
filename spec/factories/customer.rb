FactoryBot.define do
  factory :customer, class: Customer do
    sequence(:first_name) { |n| "First#{n}" }
    sequence(:last_name) { |n| "Last#{n}" }
  end
end
