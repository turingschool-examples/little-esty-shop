FactoryBot.define do
  factory :item do

    sequence :name do |n|
      "Item #{n}"
    end
    # name { Faker::Food.dish }

    sequence :description do |n|
      "Item description #{n}"
    end
    # description { Faker::Food.description }

    unit_price { 1.5 }

    merchant 
  end
end
