FactoryBot.define do
  factory :merchant do
    name {Faker::Name.name}
    status { 1 }

    trait :active do
      status { 0 }
    end

    factory :active_merchant, traits: [:active]
  end
end
