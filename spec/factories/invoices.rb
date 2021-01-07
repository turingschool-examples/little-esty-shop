FactoryBot.define do 
  factory :invoice, class: Invoice do 
    association :customer
    association :merchant
    status {["in progress", "completed", "cancelled"].sample}
  end
end