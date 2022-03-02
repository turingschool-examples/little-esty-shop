FactoryBot.define do
  factory :item, class: Item do
    sequence(:name) { |n| "Item#{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:unit_price) { |n| n }
    status { "disabled" }
    merchant 
  end
end
