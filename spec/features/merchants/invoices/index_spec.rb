# spec/features/merchants/invoices/index_spec

require 'rails_helper'

RSpec.describe 'Merchant invoices index page' do
  before :each do 
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @merchant_2 = Merchant.create!(name: 'Billy Mandmade')
    @item =  @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 75107)
    @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 75107)
    @item_3 = @merchant_2.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    @invoice_2 = Invoice.create!(customer_id: @customer.id, status: 'completed')
    InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
  end

  describe 'display' do
    it 'lists all invoices that has at least one item bought from this merchant' do
      visit "/merchants/#{@merchant.id}/invoices"
      
      expect(page).to have_content("#{@invoice.id}")
      expect(page).to_not have_content("#{@invoice_2.id}")
    end

    it 'links to each merchant invoice show page' do
      visit "/merchants/#{@merchant.id}/invoices"

      click_on("INVOICE ##{@invoice.id}")
  
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
    end
  end
end