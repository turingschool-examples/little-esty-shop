require 'rails_helper'
describe 'As a merchant' do
  describe "When I visit my merchant's invoices index '/merchants/merchant_id/invoices'" do
    before :each do
      #Merchants: 
      @max = Merchant.create!(name: 'Merch Max')
      @ross = Merchant.create!(name: 'Ross')
      #Items:
      @item_1 = @max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)
      @item_2 = @max.items.create!(name: 'Item 2', description: 'Blah', unit_price: 10)
      @item_3 = @max.items.create!(name: 'Item 3', description: 'Test', unit_price: 15)
      @item_4 = @ross.items.create!(name: 'Item 4', description: 'Fun', unit_price: 20)
      #Customers
      @sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
      #Invoices: 
      @invoice1 = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @max.id)
      @invoice2 = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @max.id)
      @invoice3 = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @max.id)
      @invoice4 = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @ross.id)
      #invoiceItems 
      @invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @item_1.id)
      @invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @item_2.id)
      @invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: @invoice3.id, item_id: @item_3.id)
      @invitm4  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: @invoice4.id, item_id: @item_4.id)
    end
    it "Then I see all of the invoices ids that include at least one of my merchant's items" do

      visit "merchants/#{@max.id}/invoices"

      within ".merchant-#{@invoice1.id}-invoice" do 
        expect(page).to have_link(@invoice1.id.to_s)
      end 

      within ".merchant-#{@invoice2.id}-invoice" do 
        expect(page).to have_link(@invoice2.id.to_s)
      end 

      within ".merchant-#{@invoice3.id}-invoice" do 
        expect(page).to have_link(@invoice3.id.to_s)
      end 

      expect(page).to_not have_content(@invoice4.id.to_s)
    end
  end
end
