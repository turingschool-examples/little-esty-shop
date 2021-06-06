# spec/features/merchants/invoices/show_spec

require 'rails_helper'

RSpec.describe 'Merchant invoice show page' do
  before :each do
    # @item = Item.find(id)
    # @merchant = Merchant.find(id)
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @merchant_2 = Merchant.create!(name: 'Billy Mandmade')
    @item =  @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 1200)
    @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 1000)
    @item_3 = @merchant_2.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 200)
    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    @invoice_2 = Invoice.create!(customer_id: @customer.id, status: 'completed')
    InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 3, unit_price: 1200, status: 1)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 10, unit_price: 1000, status: 1)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 12, unit_price: 200, status: 1)
  end
 
  describe 'display' do
    it 'shows invoice and its attributes' do
      created_at = @invoice.created_at.strftime('%A, %B %d, %Y')
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
 
      expect(page).to have_content("INVOICE # #{@invoice.id}")
      expect(page).to_not have_content("INVOICE # #{@invoice_2.id}")
      expect(page).to have_content("#{@invoice.status}")
      expect(page).to have_content("#{created_at}")
    end

    it 'lists all items and item attributes on the invoice' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_content("Qui Essie")
      expect(page).to have_content("Essie")
      expect(page).to_not have_content("Glowfish Markdown")
      expect(page).to have_content("3")
      expect(page).to have_content("$1,200.00")
    end

    it 'can update items status through dropdown list' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_button("Update Item Status")
      
      within first('.status-update') do
        expect(page).to have_content("packaged")

        select "shipped"
        click_on "Update Item Status"
      end

      expect(page).to have_content("shipped")
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
    end

    it 'lists total revenue of all items on invoice' do 
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
 
      expect(page).to have_content("Expected Total Revenue: $13,600.00")
    end
  end
end