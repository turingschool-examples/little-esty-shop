require 'rails_helper'

RSpec.describe 'The Merchant Invoice Show Page' do 
  before :each do 
    @merchant = Merchant.create!(name: 'The Duke')
    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @invoice1 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
  end 
  it 'displays all information related to that invoice' do 
    visit merchant_invoice_path(@merchant.id, @invoice1.id)
    expect(page).to have_content("Merchant Invoices Show Page")
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.format_created_at(@invoice1.created_at))
    expect(page).to have_content(@invoice1.customer_name)
    expect(page).to have_no_content(@invoice2.id)
  end 
end 