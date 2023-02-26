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
      @steve = Customer.create!(first_name: "Steve", last_name: "Stevinson")
      @invoice1 = Invoice.create!(customer: @steve, status: 1) #completed
      @invoice2 = Invoice.create!(customer: @steve, status: 1) #completed
      @invoice3 = Invoice.create!(customer: @steve, status: 1) #completed
      @invoice4 = Invoice.create!(customer: @steve, status: 1) #completed
      InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1300)
      InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1450)
      InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 1500)
      InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 1, unit_price: 1625)
      @invoice1.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice2.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice3.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success
      @invoice4.transactions.create!(credit_card_number: "4654405418249631", credit_card_expiration_date: "01/29", result: 0) #success

      #This customer has LOWEST successful transactions:
      @joe = Customer.create!(first_name: "joe", last_name: "Shmow")
      @invoice5 = Invoice.create!(customer: @joe, status: 1) #completed
      @invoice6 = Invoice.create!(customer: @joe, status: 1) #completed
      @invoice7 = Invoice.create!(customer: @joe, status: 1) #completed
      InvoiceItem.create!(item: @item5, invoice: @invoice5, quantity: 1, unit_price: 1800)
      InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 1, unit_price: 4075)
      InvoiceItem.create!(item: @item7, invoice: @invoice7, quantity: 1, unit_price: 3100)
      @invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) #failure
      @invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 1) #failure
      @invoice7.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "02/29", result: 0) #success

      @carmen = Customer.create!(first_name: "carmen", last_name: "SanDiego")
      @invoice8 = Invoice.create!(customer: @carmen, status: 1) #completed
      @invoice9 = Invoice.create!(customer: @carmen, status: 1) #completed
      InvoiceItem.create!(item: @item8, invoice: @invoice8, quantity: 1, unit_price: 3300)
      InvoiceItem.create!(item: @item9, invoice: @invoice9, quantity: 1, unit_price: 2525)
      @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 1) #failure
      @invoice8.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) #success
      @invoice9.transactions.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: "03/29", result: 0) #success

      @sally = Customer.create!(first_name: "sally", last_name: "SeaShells")
      @invoice10 = Invoice.create!(customer: @sally, status: 1) #completed
      @invoice11 = Invoice.create!(customer: @sally, status: 1) #completed
      InvoiceItem.create!(item: @item10, invoice: @invoice10, quantity: 1, unit_price: 10001)
      InvoiceItem.create!(item: @item1, invoice: @invoice11, quantity: 1, unit_price: 1400)
      @invoice10.transactions.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/29", result: 0) #success
      @invoice11.transactions.create!(credit_card_number: "4654405418249634", credit_card_expiration_date: "04/29", result: 0) #success

      @ludwig = Customer.create!(first_name: "ludwig", last_name: "van Beethoven")
      @invoice12 = Invoice.create!(customer: @ludwig, status: 1) #completed
      @invoice13 = Invoice.create!(customer: @ludwig, status: 1) #completed
      InvoiceItem.create!(item: @item2, invoice: @invoice12, quantity: 1, unit_price: 1750)
      InvoiceItem.create!(item: @item3, invoice: @invoice13, quantity: 1, unit_price: 1525)
      @invoice12.transactions.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "05/29", result: 0) #success
      @invoice13.transactions.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: "05/29", result: 0) #success

      @yukon = Customer.create!(first_name: "yukon", last_name: "Dooheet")
      @invoice14 = Invoice.create!(customer: @yukon, status: 1) #completed
      @invoice15 = Invoice.create!(customer: @yukon, status: 1) #completed
      @invoice16 = Invoice.create!(customer: @yukon, status: 1) #completed
      InvoiceItem.create!(item: @item4, invoice: @invoice14, quantity: 1, unit_price: 1500)
      InvoiceItem.create!(item: @item5, invoice: @invoice15, quantity: 1, unit_price: 1750)
      InvoiceItem.create!(item: @item6, invoice: @invoice16, quantity: 1, unit_price: 4350)
      @invoice14.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
      @invoice15.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
      @invoice16.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    end

    it 'I see a header indicating that I am on the admin dashboard' do
      visit '/admin'
      expect(page).to have_content("Admin Dashboard Page")
    end

    it "I see a link to the admin merchants index & admin invoices index pages" do
      visit '/admin'
      expect(page).to have_link("Admin Merchants Page", :href=>"/admin/merchants")
      expect(page).to have_link("Admin Invoices Page", :href=>"/admin/invoices")
    end

    it 'I see names of top 5 customers with largest number of successful transactions' do
      visit '/admin'
      expect(page).to have_content("Top 5 Customers with Highest Successful Transactions")
      expect(page).to have_content("#{@steve.first_name} #{@steve.last_name}")
      expect(page).to have_content("#{@carmen.first_name} #{@carmen.last_name}")
      expect(page).to have_content("#{@sally.first_name} #{@sally.last_name}")
      expect(page).to have_content("#{@ludwig.first_name} #{@ludwig.last_name}")
      expect(page).to have_content("#{@yukon.first_name} #{@yukon.last_name}")

      expect(page).to_not have_content("#{@joe.first_name} #{@joe.last_name}")
    end 

    it 'next to customer names, I see total count of their successful transactions' do
      visit '/admin'
      within "#top_customers-#{@steve.id}" do
        expect(page).to have_content("steve Stevinson has 4 successful transactions!")
      end

      within "#top_customers-#{@yukon.id}" do
        expect(page).to have_content("yukon Dooheet has 3 successful transactions!")
      end
    end 

    describe "User Story 22" do
      before(:each) do
        @Deniz = Customer.create!(first_name: "Deniz", last_name: "Ocean")
        @invoice17 = Invoice.create!(customer: @Deniz, status: 0) #in progress
        @invoice18 = Invoice.create!(customer: @Deniz, status: 0) #in progress
        @invoice19 = Invoice.create!(customer: @Deniz, status: 0) #in progress
        InvoiceItem.create!(item: @item7, invoice: @invoice17, quantity: 1, unit_price: 1950, status: 0) #pending
        InvoiceItem.create!(item: @item8, invoice: @invoice18, quantity: 1, unit_price: 2850, status: 2) #shipped (Expect NOT to see on page)
        InvoiceItem.create!(item: @item9, invoice: @invoice19, quantity: 1, unit_price: 1650, status: 1) #packaged
        @invoice17.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success
        @invoice18.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success
        @invoice19.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) #success

        @Emre = Customer.create!(first_name: "Emre", last_name: "Bond")
        @invoice20 = Invoice.create!(customer: @Emre, status: 0) #in progress
        InvoiceItem.create!(item: @item10, invoice: @invoice20, quantity: 1, unit_price: 9950, status: 1) #packaged
        InvoiceItem.create!(item: @item1, invoice: @invoice20, quantity: 1, unit_price: 1000, status: 2) #shipped
        @invoice17.transactions.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "08/29", result: 0) #success
      end

      it "I see 'incomplete invoices' & a list of invoice ids with unshipped items (invoice_items status = pending or packaged)" do
        visit '/admin'
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content("ID number: #{@invoice17.id}")
        expect(page).to have_content("ID number: #{@invoice19.id}")
        expect(page).to have_content("ID number: #{@invoice20.id}")

        expect(page).to_not have_content("ID number: #{@invoice18.id}")
      end

      it "each invoice id is a link to that invoice's admin show page" do
        visit '/admin'
        within "#invoice_info-#{@invoice17.id}" do
          expect(page).to have_link("#{@invoice17.id}", :href=>"/invoices/#{@invoice17.id}")
        end

        within "#invoice_info-#{@invoice19.id}" do
          expect(page).to have_link("#{@invoice19.id}", :href=>"/invoices/#{@invoice19.id}")
        end

        within "#invoice_info-#{@invoice20.id}" do
          expect(page).to have_link("#{@invoice20.id}", :href=>"/invoices/#{@invoice20.id}")
        end

        #should i test this: 
        # within "#invoice_info-#{@invoice19.id}" do
        #   expect(page).to have_link("#{@invoice19.id}", :href=>"/invoices/#{@invoice19.id}")
        #   click_link("#{@invoice19.id}")
        #   expect(current_path).to eq("/invoices/#{@invoice19.id}")
        # end
      end
    end

  end
end