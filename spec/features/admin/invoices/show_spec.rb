require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  before :each do
    @customer1 = Customer.create!(first_name: "Bobby", last_name: "Mendez")
    @invoice1 = Invoice.create!(status: "in progess", customer_id: @customer1.id)
    @merchant1 = Merchant.create!(name: "Nike")
    @item1 = Item.create!(name: "Kobe zoom 5's", description: "Best shoe in basketball hands down!", unit_price: 12500, merchant_id: @merchant1.id)
    @invoice_item1 = InvoiceItem.create!(quantity: 2, unit_price: 25000, status: 0, invoice_id: @invoice1.id, item_id: @item1.id)

    visit "/admin/invoices/#{@invoice1.id}"
  end
  
  it 'can show information related to that specific invoice' do

    expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)    
    expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))    
    expect(page).to have_content(@customer1.first_name)
    expect(page).to have_content(@customer1.last_name)
  end

  it 'can list out item names, quantity, price, and status associate with that invoice' do

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@invoice_item1.quantity)    
    expect(page).to have_content(@item1.unit_price)  
    expect(page).to have_content(@invoice_item1.status)
  end
end