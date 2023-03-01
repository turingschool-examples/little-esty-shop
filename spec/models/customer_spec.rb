require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do 
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end

  before(:each) do
    @merchant1 = Merchant.create!(name: "Mel's Travels")
    @merchant2 = Merchant.create!(name: "Hady's Beach Shack")
    @merchant3 = Merchant.create!(name: "Huy's Cheese")

    @item1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant1)
    @item2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
    @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant1)

    @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant2)
    @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant2)
    @item6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 3350, merchant: @merchant2)
    
    @item7 = Item.create!(name: "American", description: "gud cheese", unit_price: 2400, merchant: @merchant3)
    @item8 = Item.create!(name: "Swiss", description: "holes in cheese", unit_price: 3200, merchant: @merchant3)
    @item9 = Item.create!(name: "Cheddar", description: "SHARP!", unit_price: 1150, merchant: @merchant3)
    @item10 = Item.create!(name: "Imaginary", description: "it is whatever you think it is", unit_price: 9450, merchant: @merchant3)
    

    @steve = Customer.create!(first_name: "steve", last_name: "Stevinson")
    @invoice1 = Invoice.create!(customer: @steve, status: 1)
    @invoice2 = Invoice.create!(customer: @steve, status: 1)
    @invoice3 = Invoice.create!(customer: @steve, status: 1)
    @invoice4 = Invoice.create!(customer: @steve, status: 1)
    InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1300)
    InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1450)
    InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 1500)
    InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 1, unit_price: 1625)
    @invoice1.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) 
    @invoice2.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) 
    @invoice3.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) 
    @invoice4.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) 

    #This customer has LOWEST successful transactions:
    @joe = Customer.create!(first_name: "joe", last_name: "Shmow")
    @invoice5 = Invoice.create!(customer: @joe, status: 1)
    @invoice6 = Invoice.create!(customer: @joe, status: 1)
    @invoice7 = Invoice.create!(customer: @joe, status: 1)
    InvoiceItem.create!(item: @item5, invoice: @invoice5, quantity: 1, unit_price: 1800)
    InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 1, unit_price: 4075)
    InvoiceItem.create!(item: @item7, invoice: @invoice7, quantity: 1, unit_price: 3100)
    @invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) 
    @invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) 
    @invoice7.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 0) 

    @carmen = Customer.create!(first_name: "carmen", last_name: "SanDiego")
    @invoice8 = Invoice.create!(customer: @carmen, status: 1)
    @invoice9 = Invoice.create!(customer: @carmen, status: 1)
    InvoiceItem.create!(item: @item8, invoice: @invoice8, quantity: 1, unit_price: 3300)
    InvoiceItem.create!(item: @item9, invoice: @invoice9, quantity: 1, unit_price: 2525)
    @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 1) 
    @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) 
    @invoice9.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) 

    @sally = Customer.create!(first_name: "sally", last_name: "SeaShells")
    @invoice10 = Invoice.create!(customer: @sally, status: 1)
    @invoice11 = Invoice.create!(customer: @sally, status: 1)
    InvoiceItem.create!(item: @item10, invoice: @invoice10, quantity: 1, unit_price: 10001)
    InvoiceItem.create!(item: @item1, invoice: @invoice11, quantity: 1, unit_price: 1400)
    @invoice10.transactions.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/29", result: 0) 
    @invoice11.transactions.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/29", result: 0) 

    @ludwig = Customer.create!(first_name: "ludwig", last_name: "van Beethoven")
    @invoice12 = Invoice.create!(customer: @ludwig, status: 1)
    @invoice13 = Invoice.create!(customer: @ludwig, status: 1)
    InvoiceItem.create!(item: @item2, invoice: @invoice12, quantity: 1, unit_price: 1750)
    InvoiceItem.create!(item: @item3, invoice: @invoice13, quantity: 1, unit_price: 1525)
    @invoice12.transactions.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "05/29", result: 0) 
    @invoice13.transactions.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "05/29", result: 0) 

    @yukon = Customer.create!(first_name: "yukon", last_name: "Dooheet")
    @invoice14 = Invoice.create!(customer: @yukon, status: 1)
    @invoice15 = Invoice.create!(customer: @yukon, status: 1)
    @invoice16 = Invoice.create!(customer: @yukon, status: 1)
    InvoiceItem.create!(item: @item4, invoice: @invoice14, quantity: 1, unit_price: 1500)
    InvoiceItem.create!(item: @item5, invoice: @invoice15, quantity: 1, unit_price: 1750)
    InvoiceItem.create!(item: @item6, invoice: @invoice16, quantity: 1, unit_price: 4350)
    @invoice14.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) 
    @invoice15.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) 
    @invoice16.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) 
  end

  describe "class methods" do
    it "::top_5_successful_customers" do
      expect(Customer.top_5_successful_customers.to_a).to eq([@steve, @yukon, @carmen, @sally, @ludwig])
    end
  end
end
