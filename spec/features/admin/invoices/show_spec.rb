require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  before(:each) do 
    @merchant1 = Merchant.create!(name: "Mel's Travels") 
    @merchant2 = Merchant.create!(name: "Hady's Beach Shack") 

    @item1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant1)
    @item2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
    @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant1)

    @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant2)
    @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant2)
    @item6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 3350, merchant: @merchant2)
    
    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")
    @customer_2 = Customer.create!(first_name: "Joe", last_name: "Shmow")

    @invoice_1 = @customer_1.invoices.create(status: 0)
    @invoice_2 = @customer_1.invoices.create(status: 0)
    @invoice_3 = @customer_1.invoices.create(status: 0)
  
    @invoice1 = Invoice.create!(customer: @customer_1, status: 0) # in progress
    @invoice2 = Invoice.create!(customer: @customer_1, status: 2) # cancelled
    @invoice3 = Invoice.create!(customer: @customer_1, status: 1) # completed
    InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1300)
    InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1450)
    InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 1500)

    @invoice4 = Invoice.create!(customer: @customer_1, status: 1) #completed
    @ii1 = InvoiceItem.create!(item: @item1, invoice: @invoice4, quantity: 2, unit_price: 1000, status: 1) #packaged
    @ii2 = InvoiceItem.create!(item: @item2, invoice: @invoice4, quantity: 1, unit_price: 1500, status: 0) #pending
    @ii5 = InvoiceItem.create!(item: @item5, invoice: @invoice4, quantity: 4, unit_price: 2000, status: 1) #packaged
    @ii6 = InvoiceItem.create!(item: @item6, invoice: @invoice4, quantity: 5, unit_price: 5000, status: 2) #shipped 
  end 

  describe "as an admin" do 
  
   # User Story 33
    it "I see the invoice id, invoice status, created at, and customer first and last name" do 
      visit "/admin/invoices/#{@invoice1.id}"
      expect(page).to have_content("Invoice #{@invoice1.id} Page")
      expect(page).to have_content("Invoice Status: #{@invoice1.status}, Invoice Created date: #{@invoice1.created_at.strftime("%A, %B %e, %Y")}, Customer Name: #{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
    end

    # User Story 34
    it "I see the name of all the items on that invoice", :vcr do
      visit "/admin/invoices/#{@invoice4.id}"

      expect(page).to have_content("Items on Invoice")
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item5.name)
      expect(page).to have_content(@item6.name)
      expect(page).to have_content("little-esty-shop")
    end
    
    # User Story 34
    it "I also see the quantity of each item ordered, price sold for, & the invoice item status " do
      visit "/admin/invoices/#{@invoice4.id}"

      within "#item-#{@ii6.id}" do
        expect(page).to have_content("Quantity: 5")
        expect(page).to have_content("Unit Price Sold for: 5000")
        expect(page).to have_content("Invoice Item Status: shipped")
      end
    end
    
    #US36
    describe "visit admin show page" do 

      it "shows the invoice status is a select field (drop down) with the various enum statuses as the options" do   
        visit "/admin/invoices/#{@invoice_1.id}"
        expect(page).to have_selector("select[name='invoice_status']")
        expect(page).to have_select('invoice_status', with_options: [Invoice.statuses.keys[0], Invoice.statuses.keys[1], Invoice.statuses.keys[2]])
      end 

      it "see the total revenue that will be generated from this invoice" do 

        @invoice_item1 = FactoryBot.create(:invoice_item, quantity: 1, invoice_id: @invoice_1.id, unit_price: 5, item_id: @item1.id)

        @invoice_item2 = FactoryBot.create(:invoice_item, quantity: 2, invoice_id: @invoice_1.id, unit_price: 15, item_id: @item1.id)

        visit "/admin/invoices/#{@invoice_1.id}"

        expect(page).to have_content("Total Revenue Generated from this Invoice: 35")
      end

      it "the select field starts out filled out to the current status of the invoice" do

        visit "/admin/invoices/#{@invoice_1.id}"

        expect(page).to have_select('invoice_status', selected: 'in progress')
      end

      it "next to the select field there is a button to 'Update Invoice Status'" do 
        visit "/admin/invoices/#{@invoice_1.id}"

        within("div#update_invoice_status") do 
          expect(page).to have_button("Update Invoice Status")
        end 
      end 
      
      it "when you select a different options from the drop down and click the update invoice status button, you return to the invoice show page and the invoice status has changed" do 

      visit "/admin/invoices/#{@invoice_1.id}"
        expect(page).to have_select('invoice_status', selected: 'in progress')

        select Invoice.statuses.keys[2], from: "invoice_status"

        click_button("Update Invoice Status")

        expect(page).to have_select('invoice_status', selected: 'cancelled')

        expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
      end

      it "shows teh invoice id, invoice status, created at, and customer first and last name" do 

        visit "/admin/invoices/#{@invoice_1.id}"
        expect(page).to have_content("Invoice ID: #{@invoice_1.id}") 
        expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
        expect(page).to have_content("Invoice Created date: #{@invoice_1.created_at}") 
        expect(page).to have_content("Customer Name: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
      end
    end
  end
end
