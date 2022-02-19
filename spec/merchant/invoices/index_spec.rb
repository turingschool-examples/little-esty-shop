require 'rails_helper'

RSpec.describe 'The Merchant Invoices Index' do 
  before :each do 
    @merchant = Merchant.create!(name: 'The Duke')
    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @invoice1 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
    # visit merchant_invoices_path(@merchant.id)
  end 
  it 'displays all invoices that include a merchants items' do 
    # visit isn't working 
    # visit merchant_invoices_path(@merchant.id)
    # visit "/merchants/#{@merchant.id}/invoices"
    save_and_open_page
    expect(page).to have_content("Merchant Invoices Index")
  end 
end 