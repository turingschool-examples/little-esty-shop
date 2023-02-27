require 'rails_helper'

RSpec.describe 'Merchant Dashboard Feature Spec' do
  before(:each) do
    ###### Merchants & Items ######
    @merchant1 = Merchant.create!(name: "Mel's Travels")
    @merchant2 = Merchant.create!(name: "Hady's Beach Shack")

    @item1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant1)
    @item2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
    @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant1)

    @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant2)
    @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant2)
    @item6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 3350, merchant: @merchant2)
    
    ###### Customers, Invoices, Invoice_Items, & Transactions ######
    @customer1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")
    @invoice1 = Invoice.create!(customer: @customer1, status: 1) #completed
    @invoice2 = Invoice.create!(customer: @customer1, status: 1) #completed
    @invoice3 = Invoice.create!(customer: @customer1, status: 1) #completed
    @invoice4 = Invoice.create!(customer: @customer1, status: 1) #completed
    InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1300)
    InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1450)
    InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 1500)
    InvoiceItem.create!(item: @item3, invoice: @invoice4, quantity: 1, unit_price: 1625)
    @invoice1.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
    @invoice2.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
    @invoice3.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
    @invoice4.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success

    #This customer has LOWEST successful transactions:
    @customer2 = Customer.create!(first_name: "Joe", last_name: "Shmow")
    @invoice5 = Invoice.create!(customer: @customer2, status: 1) #completed
    @invoice6 = Invoice.create!(customer: @customer2, status: 1) #completed
    @invoice7 = Invoice.create!(customer: @customer2, status: 1) #completed
    InvoiceItem.create!(item: @item1, invoice: @invoice5, quantity: 1, unit_price: 1800)
    InvoiceItem.create!(item: @item2, invoice: @invoice6, quantity: 1, unit_price: 4075)
    InvoiceItem.create!(item: @item3, invoice: @invoice7, quantity: 1, unit_price: 3100)
    @invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) #failure
    @invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) #failure
    @invoice7.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 0) #success

    @customer3 = Customer.create!(first_name: "Carmen", last_name: "SanDiego")
    @invoice8 = Invoice.create!(customer: @customer3, status: 1) #completed
    @invoice9 = Invoice.create!(customer: @customer3, status: 1) #completed
    InvoiceItem.create!(item: @item2, invoice: @invoice8, quantity: 1, unit_price: 3300)
    InvoiceItem.create!(item: @item3, invoice: @invoice9, quantity: 1, unit_price: 2525)
    @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 1) #failure
    @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) #success
    @invoice9.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) #success

    @customer4 = Customer.create!(first_name: "Sally", last_name: "SeaShells")
    @invoice10 = Invoice.create!(customer: @customer4, status: 1) #completed
    @invoice11 = Invoice.create!(customer: @customer4, status: 1) #completed
    InvoiceItem.create!(item: @item3, invoice: @invoice10, quantity: 1, unit_price: 10001)
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
    InvoiceItem.create!(item: @item2, invoice: @invoice14, quantity: 1, unit_price: 1500)
    InvoiceItem.create!(item: @item3, invoice: @invoice15, quantity: 1, unit_price: 1750)
    InvoiceItem.create!(item: @item1, invoice: @invoice16, quantity: 1, unit_price: 4350)
    @invoice14.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    @invoice15.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    @invoice16.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
  end 

  describe "as a visitor" do #user story 1 
    describe "visit merchant dashboard" do 
      it "the visitor will see the name of the merchant" do 

        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_content("Merchant Name: #{@merchant1.name}")

        visit "/merchants/#{@merchant2.id}/dashboard"

        expect(page).to have_content("Merchant Name: #{@merchant2.name}")

      end

      it "see the link to merchant items index" do 
        
        visit "/merchants/#{@merchant1.id}/dashboard" 

        expect(page).to have_link("#{@merchant1.name}'s Items", href: "/merchants/#{@merchant1.id}/items")

        expect(page).to have_link("#{@merchant1.name}'s Invoices", href: "/merchants/#{@merchant1.id}/invoices")

      end

      it 'see the names of the 5 customers with successfull transactions for the merchant' do
        visit "/merchants/#{@merchant1.id}/dashboard" 

        expect(page).to have_content("Top 5 Customers with Highest Successful Transactions for this Merchant")
        expect(page).to have_content(@customer1.first_name)
        expect(page).to have_content(@customer1.last_name)
        expect(page).to have_content(@customer3.first_name)
        expect(page).to have_content(@customer3.last_name)
        expect(page).to have_content(@customer4.first_name)
        expect(page).to have_content(@customer4.last_name)
        expect(page).to have_content(@customer5.first_name)
        expect(page).to have_content(@customer5.last_name)
        expect(page).to have_content(@customer6.first_name)
        expect(page).to have_content(@customer6.last_name)
        expect(page).to_not have_content(@customer2.first_name)
      end

      xit 'see the total number of successful transactions for each customer' do
        visit "/merchants/#{@merchant1.id}/dashboard" 
        
        within "#top_customers-#{@customer1.id}" do
          expect(page).to have_content("Steve Stevinson has 4 successful transactions!")
        end

        within "#top_customers-#{@customer6.id}" do
          expect(page).to have_content("Yukon Dooheet has 3 successful transactions!")
        end
      end
    end

    #US 4 and 5
    describe 'merchant unshipped items' do
      before(:each) do
        @deniz = Customer.create!(first_name: "Deniz", last_name: "Ocean")
        @invoice17 = Invoice.create!(customer: @deniz, created_at: 5.days.ago, status: 0) #in progress
        @invoice18 = Invoice.create!(customer: @deniz, created_at: 2.days.ago, status: 0) #in progress
        @invoice19 = Invoice.create!(customer: @deniz, created_at: 4.days.ago, status: 0) #in progress
        InvoiceItem.create!(item: @item4, invoice: @invoice17, quantity: 1, unit_price: 1950, status: 0) #pending
        InvoiceItem.create!(item: @item5, invoice: @invoice18, quantity: 1, unit_price: 2850, status: 2) #shipped (Expect NOT to see on page)
        InvoiceItem.create!(item: @item6, invoice: @invoice19, quantity: 1, unit_price: 1650, status: 1) #packaged
        @invoice17.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success
        @invoice18.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success
        @invoice19.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success

        @emre = Customer.create!(first_name: "Emre", last_name: "Bond")
        @invoice20 = Invoice.create!(customer: @emre, created_at: 3.days.ago, status: 0) #in progress
        InvoiceItem.create!(item: @item4, invoice: @invoice20, quantity: 1, unit_price: 9950, status: 1) #packaged
        InvoiceItem.create!(item: @item6, invoice: @invoice20, quantity: 1, unit_price: 1000, status: 2) #shipped
        @invoice17.transactions.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "08/29", result: 0) #success
      end

      it 'I see Items Ready to Ship & a list of unshipped item names and next to each name is the item invoice id' do
        visit "/merchants/#{@merchant2.id}/dashboard" 

        expect(page).to have_content("Items Ready to Ship")
        expect(page).to have_content("Item name: #{@item4.name}, Item Invoice Id: #{@invoice17.id}")
        expect(page).to have_content("Item name: #{@item6.name}, Item Invoice Id: #{@invoice19.id}")
        expect(page).to have_content("Item name: #{@item4.name}, Item Invoice Id: #{@invoice20.id}")

        expect(page).to_not have_content("#{@item5.name}")
      end

      it 'each items invoice ID is a link my merchant invoice show page' do
        visit "/merchants/#{@merchant2.id}/dashboard" 
        
        expect(page).to have_link("#{@invoice17.id}", :href=>"/merchants/#{@merchant2.id}/invoices/#{@invoice17.id}")
        expect(page).to have_link("#{@invoice19.id}", :href=>"/merchants/#{@merchant2.id}/invoices/#{@invoice19.id}")
        expect(page).to have_link("#{@invoice20.id}", :href=>"/merchants/#{@merchant2.id}/invoices/#{@invoice20.id}")
      end

      it "next to each id I see the date that invoice was created (ex: 'Monday, July 18, 2019')" do
        visit "/merchants/#{@merchant2.id}/dashboard" 
        
        within "#invoice_items_info-#{@invoice17.id}" do
          expect(page).to have_content("Created: #{@invoice17.created_at.strftime("%A, %B %e, %Y")}")
        end

        within "#invoice_items_info-#{@invoice20.id}" do
          expect(page).to have_content("Created: #{@invoice20.created_at.strftime("%A, %B %e, %Y")}")
        end
      end

      it "I see the list is ordered from oldest to newest" do
        visit "/merchants/#{@merchant2.id}/dashboard" 
        expect(@invoice17.created_at.strftime("%A, %B %e, %Y")).to appear_before(@invoice19.created_at.strftime("%A, %B %e, %Y"))
        expect(@invoice19.created_at.strftime("%A, %B %e, %Y")).to appear_before(@invoice20.created_at.strftime("%A, %B %e, %Y"))
      end
    end
  end
end 
