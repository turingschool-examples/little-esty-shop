FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "fn_#{n}" }
    sequence(:last_name) { |n| "ln_#{n}" }
  end
end
