# spec/features/merchants/dashboard_spec

require 'rails_helper'

RSpec.describe 'Merchants dashboard show page' do 
  describe 'display' do
    before :each do 
      @merchant = Merchant.create!(name: 'Sally Handmade')
      @item =  @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 75107)
      @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 75107)
      @item_3 = @merchant.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
      @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 
      @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
      InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 2)
    end

    it 'shows name of merchant' do
      visit "/merchants/#{@merchant.id}/dashboard"
      
      expect(page).to have_content('Sally Handmade')
    end

    it 'links to merchant items index' do
      visit "/merchants/#{@merchant.id}/dashboard"

      click_on 'All Items'

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it 'links to merchant invoices index' do
      visit "/merchants/#{@merchant.id}/dashboard"

      click_on 'All Invoices'

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end

    it 'lists names of all items that are ready to ship' do
      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content("Qui Essie")
      expect(page).to have_content("Essie")
      expect(page).to_not have_content("Glowfish")
    end

    it 'lists items by oldest invoice created date' do
      visit "/merchants/#{@merchant.id}/dashboard"

    end

    it 'lists corresponding invoice id of each item' do
      visit "/merchants/#{@merchant.id}/dashboard"
      
      expect(page).to have_content("##{@invoice.id}")
    end

    it 'links to corresponding merchant invoice show page' do
      visit "/merchants/#{@merchant.id}/dashboard"

      first(:link, "#{@invoice.id}").click

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end

    it 'contains a table showing the top 5 customers by successful transactions' do
      visit "/merchants/#{@merchant.id}/dashboard"
      
      expect(page).to have_content('Alessandra Ward')
      expect(page).to have_content('Ben Turner')
      expect(page).to have_content('Estel Hermiston')
      expect(page).to have_content('Helmer Baumbach')
      expect(page).to have_content('Isaac Zulauf')
    end
  end
end