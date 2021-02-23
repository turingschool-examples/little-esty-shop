FactoryBot.define do
  factory :customer do
    sequence :first_name do |n|
      "First Name #{n}"
    end
    sequence :last_name do |n|
      "Last Name #{n}"
    end
  end
end
