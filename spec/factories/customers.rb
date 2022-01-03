FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "Default First Name #{n}" }
    sequence(:last_name) { |n| "Default Last Name #{n}" }
  end
end
