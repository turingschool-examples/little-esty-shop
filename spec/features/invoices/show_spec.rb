require 'rails_helper'

RSpec.describe 'Show page', type: :feature do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @merchant_2 = Merchant.create!(name: 'Jewelry')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant_2.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Joy', last_name: 'Smith')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2, created_at: "2012-03-28 14:54:09")
    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end

  describe 'invoice show page' do
    xit 'shows invoice information' do

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content("Created at: Monday, November 8, 2021")
    end

    it 'shows invoice customer details' do

      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
    end

    it 'shows item information' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@ii_1.unit_price)
      expect(page).to have_content(@ii_1.quantity)
      expect(page).to have_content(@ii_1.status)
      
      expect(page).to_not have_content(@item_2.name)
    end
  end
end
