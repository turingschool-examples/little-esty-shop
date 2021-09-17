require 'rails_helper'

RSpec.describe 'Admin Invoice Show page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Cool Shirts")
    @customer_1 = Customer.create!(first_name: 'Bob', last_name: 'Johnson')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'cancelled')
    @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
    @invoice_item = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 5, unit_price: 1200, status: "packaged")
  end

  it 'shows invoice information' do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
  end

  it 'lists all items on invoice with name, quantity, price, item status' do
    visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item.quantity)
    expect(page).to have_content(@invoice_item.unit_price)
    expect(page).to have_content(@invoice_item.status)
  end
end
