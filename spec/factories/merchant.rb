FactoryBot.define do
  factory :merchant do
    name { Faker::Superhero.unique.name }

    factory :merchant_with_items do
      name { Faker::FunnyName.unique.name }

      transient do
        items_count { 5 }
      end

      after(:create) do |merchant, amount|
        create_list(:item, amount.items_count, merchant: merchant)
      end
    end
  end
end
