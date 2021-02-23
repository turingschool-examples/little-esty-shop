FactoryBot.define do
  factory :merchant do
    sequence :name do |n|
      "Merchant #{n}"
    end
  end
end
