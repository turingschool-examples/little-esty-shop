# spec/features/merchants/invoices/show_spec

require 'rails_helper'

RSpec.describe 'Merchant invoice show page' do
  before :each do 
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @merchant_2 = Merchant.create!(name: 'Billy Mandmade')
    @item =  @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 75107)
    @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 75107)
    @item_3 = @merchant_2.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    @invoice_2 = Invoice.create!(customer_id: @customer.id, status: 'completed')
    InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 'packaged')
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 'packaged')
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 'packaged')
  end
 
  describe 'display' do
    it 'shows invoice and its attributes' do
      created_at = @invoice.created_at.strftime('%A, %B %d, %Y')
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
 
      expect(page).to have_content("INVOICE # #{@invoice.id}")
      expect(page).to_not have_content("INVOICE # #{@invoice_2.id}")
      expect(page).to have_content("Status: #{@invoice.status}")
      expect(page).to have_content("Created At: #{created_at}")
    end

    it 'lists all items and item attributes on the invoice'

    it 'lists total revenue of all items on invoice' 

    it 'can update items status' 
  end
end