require 'rails_helper'

RSpec.describe 'Admin Dashboard/Index page' do
  before :each do
    @merchant = Merchant.create!(name: "Al Capone", created_at: Time.now, updated_at: Time.now)

    @item_1 = Item.create!(name: "Moonshine", description: "alcohol", unit_price: 2, created_at: Time.now, updated_at: Time.now, merchant_id: @merchant.id)

    @customer_1 = Customer.create!(first_name: "Babe", last_name: "Ruth", created_at: Time.now, updated_at: Time.now)
    @customer_2 = Customer.create!(first_name: "Charles", last_name: "Bukowski", created_at: Time.now, updated_at: Time.now)
    @customer_3 = Customer.create!(first_name: "Josey", last_name: "Wales", created_at: Time.now, updated_at: Time.now)
    @customer_4 = Customer.create!(first_name: "Popcorn", last_name: "Sutton", created_at: Time.now, updated_at: Time.now)
    @customer_5 = Customer.create!(first_name: "Nucky", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
    @customer_6 = Customer.create!(first_name: "Freddy", last_name: "McCoy", created_at: Time.now, updated_at: Time.now)

    @invoice_1 = Invoice.create!(status: 0, created_at: '2022-07-30 00:00:00 UTC', updated_at: Time.now, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, created_at: '2022-07-29 00:00:00 UTC', updated_at: Time.now, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 0, created_at: '2022-07-28 00:00:00 UTC', updated_at: Time.now, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: @customer_6.id)

    @invoice_item_1 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 1, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 2, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_4.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_5.id)
    @invoice_item_6 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 1, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_6.id)
  end

  it 'displays admin dashboard header' do
    visit admin_index_path
    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

end
