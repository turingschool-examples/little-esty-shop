FactoryBot.define do 
  factory :item do 
    name { 'feet pics' }
    description { 'pics of feet' }
    unit_price { 500000 }
    merchant
  end
end