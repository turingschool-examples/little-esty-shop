FactoryBot.define do
  factory :customer do
    sequence(:first_name) {|n| "first name #{n}"}
    sequence(:last_name) {|n| "last name #{n}"}
  end
end
