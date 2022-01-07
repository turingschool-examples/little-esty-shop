require 'rails_helper'

RSpec.describe 'admin index page' do
  it "has a header indicating you are on the admin dashboard" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)

    #invoice 0 = cancelled, 1 = in_progress, 2 = completed
    #invoice_item 0 = packaged, 1 = pending, 2 = shipped
    #incomplete_invoices
      #invoice_items.where('status = ?', 0 || 1)


    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: 'item_3', description: 'item_2_description', unit_price: 2, merchant_id: merchant_2.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 3, status: 2)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 3, status: 0)
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it "has links to admin merchants and invoices index" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)

    #invoice 0 = cancelled, 1 = in_progress, 2 = completed
    #invoice_item 0 = packaged, 1 = pending, 2 = shipped
    #incomplete_invoices
      #invoice_items.where('status = ?', 0 || 1)


    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: 'item_3', description: 'item_2_description', unit_price: 2, merchant_id: merchant_2.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 3, status: 2)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 3, status: 0)
    visit '/admin'

    expect(page).to have_link('Merchants')
    expect(page).to have_link('Invoices')
  end

  it "has a section for all incomplete invoices id's" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)

    #invoice 0 = cancelled, 1 = in_progress, 2 = completed
    #invoice_item 0 = packaged, 1 = pending, 2 = shipped
    #incomplete_invoices
      #invoice_items.where('status = ?', 0 || 1)


    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    item_3 = Item.create!(name: 'item_3', description: 'item_2_description', unit_price: 2, merchant_id: merchant_2.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 3, status: 2)
    invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 3, status: 0)
    visit '/admin'
    expect(page).to have_content("Incomplete Invoices: #{invoice_1.id} #{invoice_3.id}")
    expect(page).to_not have_content(invoice_2.id)
  end
end
