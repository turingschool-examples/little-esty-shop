FactoryBot.define do
  factory :customer do
    invoice
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end
end
