require 'rails_helper'

RSpec.describe '/admin', type: :feature do
  describe 'when I visit the admin dashboard' do
    before(:each) do
      ###### Merchants & Items ######
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
      
      ###### Customers, Invoices, Invoice_Items, & Transactions ######
      @customer1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")
      @invoice1 = Invoice.create!(customer: @customer1, status: 1) #completed
      @invoice2 = Invoice.create!(customer: @customer1, status: 1) #completed
      @invoice3 = Invoice.create!(customer: @customer1, status: 1) #completed
      @invoice4 = Invoice.create!(customer: @customer1, status: 1) #completed
      InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1300)
      InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1450)
      InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 1500)
      InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 1, unit_price: 1625)
      @invoice1.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice2.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice3.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice4.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success

      #This customer has LOWEST successful transactions:
      @customer2 = Customer.create!(first_name: "Joe", last_name: "Shmow")
      @invoice5 = Invoice.create!(customer: @customer2, status: 1) #completed
      @invoice6 = Invoice.create!(customer: @customer2, status: 1) #completed
      @invoice7 = Invoice.create!(customer: @customer2, status: 1) #completed
      InvoiceItem.create!(item: @item5, invoice: @invoice5, quantity: 1, unit_price: 1800)
      InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 1, unit_price: 4075)
      InvoiceItem.create!(item: @item7, invoice: @invoice7, quantity: 1, unit_price: 3100)
      @invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) #failure
      @invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) #failure
      @invoice7.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 0) #success

      @customer3 = Customer.create!(first_name: "Carmen", last_name: "SanDiego")
      @invoice8 = Invoice.create!(customer: @customer3, status: 1) #completed
      @invoice9 = Invoice.create!(customer: @customer3, status: 1) #completed
      InvoiceItem.create!(item: @item8, invoice: @invoice8, quantity: 1, unit_price: 3300)
      InvoiceItem.create!(item: @item9, invoice: @invoice9, quantity: 1, unit_price: 2525)
      @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 1) #failure
      @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) #success
      @invoice9.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) #success

      @customer4 = Customer.create!(first_name: "Sally", last_name: "SeaShells")
      @invoice10 = Invoice.create!(customer: @customer4, status: 1) #completed
      @invoice11 = Invoice.create!(customer: @customer4, status: 1) #completed
      InvoiceItem.create!(item: @item10, invoice: @invoice10, quantity: 1, unit_price: 10001)
      InvoiceItem.create!(item: @item1, invoice: @invoice11, quantity: 1, unit_price: 1400)
      @invoice10.transactions.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/29", result: 0) #success
      @invoice11.transactions.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/29", result: 0) #success

      @customer5 = Customer.create!(first_name: "Ludwig", last_name: "van Beethoven")
      @invoice12 = Invoice.create!(customer: @customer5, status: 1) #completed
      @invoice13 = Invoice.create!(customer: @customer5, status: 1) #completed
      InvoiceItem.create!(item: @item2, invoice: @invoice12, quantity: 1, unit_price: 1750)
      InvoiceItem.create!(item: @item3, invoice: @invoice13, quantity: 1, unit_price: 1525)
      @invoice12.transactions.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "05/29", result: 0) #success
      @invoice13.transactions.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "05/29", result: 0) #success

      @customer6 = Customer.create!(first_name: "Yukon", last_name: "Dooheet")
      @invoice14 = Invoice.create!(customer: @customer6, status: 1) #completed
      @invoice15 = Invoice.create!(customer: @customer6, status: 1) #completed
      @invoice16 = Invoice.create!(customer: @customer6, status: 1) #completed
      InvoiceItem.create!(item: @item4, invoice: @invoice14, quantity: 1, unit_price: 1500)
      InvoiceItem.create!(item: @item5, invoice: @invoice15, quantity: 1, unit_price: 1750)
      InvoiceItem.create!(item: @item6, invoice: @invoice16, quantity: 1, unit_price: 4350)
      @invoice14.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
      @invoice15.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
      @invoice16.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success

      visit '/admin'
    end

    it 'I see a header indicating that I am on the admin dashboard' do
      expect(page).to have_content("Admin Dashboard Page")
    end

    it "I see a link to the admin merchants index & admin invoices index pages" do
      expect(page).to have_link("Admin Merchants Page", :href=>"/admin/merchants")
      expect(page).to have_link("Admin Invoices Page", :href=>"/admin/invoices")
    end

    it 'I see names of top 5 customers with largest number of successful transactions' do
      expect(page).to have_content("Top 5 Customers with Highest Successful Transactions")
      expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}")
      expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name}")
      expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name}")
      expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}")
      expect(page).to have_content("#{@customer6.first_name} #{@customer6.last_name}")

      expect(page).to_not have_content("#{@customer2.first_name} #{@customer2.last_name}")
    end 

    it 'next to customer names, I see total count of their successful transactions' do
      within "#top_customers-#{@customer1.id}" do
        expect(page).to have_content("Steve Stevinson has 4 successful transactions!")
      end

      within "#top_customers-#{@customer6.id}" do
        expect(page).to have_content("Yukon Dooheet has 3 successful transactions!")
      end
    end 

  end
end