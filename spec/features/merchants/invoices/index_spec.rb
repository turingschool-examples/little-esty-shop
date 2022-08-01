require 'rails_helper'

RSpec.describe 'Merchant Invoice Index Page' do
  it "lists invoices" do
    merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
    merchant2 = Merchant.create!(name: "Billy West", created_at: Time.now, updated_at: Time.now)

    item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

    customer1 = Customer.create!(first_name: "Susan", last_name: "Sarandon", created_at: Time.now, updated_at: Time.now)

    invoice1 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer1.id)
    invoice2 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer1.id)

    invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, created_at: Time.now, updated_at: Time.now, quantity: 2, unit_price: 2, status: 1)
    invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, created_at: Time.now, updated_at: Time.now, quantity: 2, unit_price: 2, status: 1)
    invoiceitem3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, created_at: Time.now, updated_at: Time.now, quantity: 1, unit_price: 2, status: 1)

    visit merchant_invoices_path(merchant1)
    expect(page).to have_link("Invoice ##{invoice1.id}")
    click_link("Invoice ##{invoice1.id}")
    expect(current_path).to eq(merchant_invoices_path(merchant1, invoice1))
  end
end
