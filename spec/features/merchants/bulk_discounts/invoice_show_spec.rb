require 'rails_helper'

RSpec.describe 'merchant bulk discount create' do
  before :each do
    @merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
    @customer1 = Customer.create(first_name: 'Jack', last_name: 'Black')
    @discount1 = BulkDiscount.create(merchant_id: @merchant1.id, threshold: 15, discount: 10)
    @invoice1 = Invoice.create(status: "completed", customer_id: @customer1.id)
    @item1 = Item.create(name: 'Fountian Pen', description: 'The fanciest of pens', unit_price: 10, merchant_id: @merchant1.id)
    @invoice_item1 = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 20, unit_price: 1000, status: 'shipped')

  end

  it 'can display the total price after discounts' do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    expect(page).to have_content("Discounted Revenue: $180.00")
  end

  it 'can link an invoice_item to the applied discount show page' do
    visit merchant_invoice_path(@merchant1.id, @invoice1.id)

    click_on "View Discount Applied"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/#{@discount1.id}")
  end

end
