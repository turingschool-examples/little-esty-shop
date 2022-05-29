FactoryBot.define do 
  factory :transactions do
    credit_card_number{ 4444962945648823 }
    credit_card_expiration_date { "" }
    result { 1 }
    invoice
  end
end