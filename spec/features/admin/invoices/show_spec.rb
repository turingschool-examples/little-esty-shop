require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  before(:each) do 
    @merchant1 = Merchant.create!(name: "Mel's Travels", uuid: 1) 
    @merchant2 = Merchant.create!(name: "Hady's Beach Shack", uuid: 2) 

    @item1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant1)
    @item2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
    @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant1)

    @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant2)
    @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant2)
    @item6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 3350, merchant: @merchant2)
    
    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")
    @customer_2 = Customer.create!(first_name: "Joe", last_name: "Shmow")

    @invoice1 = Invoice.create!(customer: @customer_1, status: 0) # in progress
    @invoice2 = Invoice.create!(customer: @customer_1, status: 2) # cancelled
    @invoice3 = Invoice.create!(customer: @customer_1, status: 1) # completed
    InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1300)
    InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1450)
    InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 1500)

    @invoice4 = Invoice.create!(customer: @customer_1, status: 1) #completed
    InvoiceItem.create!(item: @item1, invoice: @invoice4, quantity: 1, unit_price: 1000)
    InvoiceItem.create!(item: @item2, invoice: @invoice4, quantity: 1, unit_price: 1500)
    InvoiceItem.create!(item: @item5, invoice: @invoice4, quantity: 1, unit_price: 2000)
    InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 1, unit_price: 5000)
  end 

  describe "as an admin" do 
    # User Story 33
    it "I see the invoice id, invoice status, created at, and customer first and last name" do 
      visit "/admin/invoices/#{@invoice1.id}"
      expect(page).to have_content("Invoice #{@invoice1.id} Page")
      expect(page).to have_content("Invoice Status: #{@invoice1.status}, Invoice Created date: #{@invoice1.created_at.strftime("%A, %B %e, %Y")}, Customer Name: #{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
    end

    # User Story 34
    it "I see the name of all the items on that invoice" do
      visit "/admin/invoices/#{@invoice4.id}"
      expect(page).to have_content("Items on Invoice")

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item5.name)
    end

    # User Story 34
    xit "I also see the quantity of each item ordered, price sold for, & the invoice item status " do
      visit "/admin/invoices/#{@invoice4.id}"
      within "#item_info-#{@item1.id}" do
        expect(page).to have_content(@item1.name)
      end
    end
  end
end
