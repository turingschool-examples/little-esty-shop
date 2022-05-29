FactoryBot.define do 
  factory :customer do 
    first_name { "Bill" }
    last_name { "Ted" }
    #in customer.rb can call customer = create!(:customer), can overwrite with customer = create!(:customer, first_name: "Geraldo")
    
  end
end

#create lists(more than one customer) with customers = create_list(:customers, 3), or customers_1, customers_2, customers_3 = create_list(:customer, 3)

