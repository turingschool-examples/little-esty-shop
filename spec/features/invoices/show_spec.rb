require 'rails_helper'

RSpec.describe 'invoice show page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id)
  end

  it 'displays the invoice id, status, created at, and customer name' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at}") #need to parse it to read day of week, month day, year
    expect(page).to have_content("#{@customer.first_name}")
    expect(page).to have_content("#{@customer.last_name}")
  end
end
