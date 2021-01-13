require 'rails_helper'
describe 'As a merchant' do
  describe "When I visit my merchant's invoice show page '/merchants/merchant_id/invoices/invoice_id'" do
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
      @sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith', address: 'Test Address')
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
      @invitm5  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 10, invoice_id: @invoice1.id, item_id: @item_2.id)
    end

    it "Then I can see information related to that invoice including id, status, created at" do
      visit "merchants/#{@max.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
    end

    it "Then I see all of my items on the invoice including: name, quantity, price" do
      visit "merchants/#{@max.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.unit_price)
      expect(page).to have_content(@invitm1.quantity)
    end

    it 'Then I see all of the customer information related to that invoice including: first_name, last_name, shipping address' do
      visit "merchants/#{@max.id}/invoices/#{@invoice1.id}"

      within '.customer-information' do
        expect(page).to have_content('Customer Information')
        expect(page).to have_content("First Name: #{@sally.first_name}")
        expect(page).to have_content("Last Name: #{@sally.last_name}")
        expect(page).to have_content("Address: #{@sally.address}")
      end
    end

    it "Then I see that each invoice item status is a select field and the item's current status is selected" do
      visit "merchants/#{@max.id}/invoices/#{@invoice1.id}"

      expect(page).to have_select('Status:', :options => ['packaged', 'pending', 'shipped'], :selected => 'packaged')
    end

    describe 'When I click this select field' do
      before :each do
        visit "merchants/#{@max.id}/invoices/#{@invoice1.id}"

        select 'pending', from: 'Status:'
      end

      it 'Then I can select a new status for the Item' do
        expect(page).to have_button('Update Item Status')
      end

      describe 'When I click this button' do
        it "Then I am taken back to the merchant invoice show page and Item's status has now been updated" do
          click_button('Update Item Status')

          expect(current_path).to eq("/merchants/#{@max.id}/invoices/#{@invoice1.id}")
          expect(page).to have_select('Status:', :selected => 'pending')
        end
      end

    it 'Then I see the total revenue that will be generated from all of my items on the invoice' do
      expected_revenue = @invitm1.quantity * @invitm1.unit_price + @invitm5.quantity * @invitm5.unit_price
      
      visit "merchants/#{@max.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("Total Revenue: #{(expected_revenue)}")
    end
  end
end
