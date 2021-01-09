require 'rails_helper'

RSpec.describe 'as an admin', type: :feature do
  describe 'when I visit and admin invoices show page' do
    before(:each) do
      @merchant = Merchant.create!(name: 'House of thingys')
      @customer = Customer.create!(first_name: 'Hooman', last_name:"Mcbuythings", shipping_address: "Bouldah!")
      @invoice_1 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 0, created_at: 2012-03-25)
      @invoice_2 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 0)
      @invoice_3 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 1)
      @item_1 = Item.create!(name: 'doo hickey', description: 'more fun than a hootenany!', unit_price: 23, merchant_id: @merchant.id)
      @item_2 = Item.create!(name: 'doo hickey pro', description: 'gooolllld', unit_price: 40, merchant_id: @merchant.id)
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: @item_1.unit_price, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_2.unit_price, status: 1)
    end

    it 'then i see invoice id, status and created at date formated as "Monday, July 18, 2019"' do
      merchant = Merchant.create!(name: 'House of thingys')
      customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe')
      invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant.id, status: 0, created_at: 2019-07-18)

      visit admin_invoice_path("#{invoice_1.id}")

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content(invoice_1.status)
      expect(page).to have_content(invoice_1.date_time)
    end

    it 'I see customer information' do
      visit admin_invoice_path("#{@invoice_1.id}")

      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
      expect(page).to have_content(@customer.shipping_address)
    end

    it 'I see invoice item information' do
      visit admin_invoice_path("#{@invoice_1.id}")

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@invoice_item_1.quantity)
      expect(page).to have_content(@invoice_item_2.quantity)
      expect(page).to have_content(@invoice_item_1.unit_price)
      expect(page).to have_content(@invoice_item_2.unit_price)
      expect(page).to have_content(@invoice_item_1.status)
      expect(page).to have_content(@invoice_item_2.status)
    end
  end
end
