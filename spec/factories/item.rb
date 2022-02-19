FactoryBot.define do
  factory :item, class: Item do
    sequence(:name) { |n| "First#{n} Last#{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:unit_price) { |n| n }
    merchant 
  end
end
