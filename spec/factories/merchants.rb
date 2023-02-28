FactoryBot.define do
  factory :merchant do
    name {Faker::Name.name}
    status { 0 }

    trait :active do
      status { 1 }
    end

    factory :active_merchant, traits: [:active]
  end
end
