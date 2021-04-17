require 'rails_helper'

RSpec.describe "Admin Invoices Show Page" do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @customer = create(:customer)
    @invoice = Invoice.create!(status: 0, customer_id: @customer.id)
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice.id, quantity: 3, unit_price: 13, status: 0)
    visit "/admin/invoices/#{@invoice.id}"
  end

  it 'can see invoice id, status, created_at date, customer first and last name' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  it 'can see all items and their names, quantity ordered, price items sold for, and invoice item status' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_1.status)
  end
end
