require 'rails_helper'

RSpec.describe 'merchant invoice index page' do
  before(:each) do
    @merchant = Merchant.create!(name: "Parker")
    @item = @merchant.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)
    @item2 = @merchant.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)
    @customer = Customer.create!(first_name: "Fred", last_name: "Rogers")
    @invoice = @customer.invoices.create!(status: "in progress")
    @invoice_item = InvoiceItem.create!(invoice: @invoice, item: @item, quantity: 20, unit_price: 400, status: "pending")
    visit "/merchants/#{@merchant.id}/invoices"
  end

  it 'shows each merchant invoice id' do
    expect(page).to have_content(@invoice.id)
  end


end
