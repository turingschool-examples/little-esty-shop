FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "Item #{n}"
    end
    description { "description" }
    sequence :unit_price do |n|
      n * 2
    end
    merchant
  end
end
