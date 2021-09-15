FactoryBot.define do
  factory :item do
    name         { "cookies" }
    description  { "whoopdie-doo!" }
    unit_price   { 12345 }
    merchant
  end
end
