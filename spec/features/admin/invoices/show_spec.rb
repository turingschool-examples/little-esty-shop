require 'rails_helper'

RSpec.describe 'admin invoices show page' do
  it 'has all invoice ids as links' do
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)

    visit admin_invoice_path(invoice_1.id)

    expect(page).to have_content("Invoice Id: #{invoice_1.id}")
    expect(page).to have_content("Created: #{invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer First Name: #{invoice_1.customer.first_name}")
    expect(page).to have_content("Customer Last Name: #{invoice_1.customer.last_name}")
  end

  it 'has all items on an invoice with name, quantity, sold for and status' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 3, status: 2)

    visit admin_invoice_path(invoice_1.id)

    expect(page).to have_content("Item: #{item_1.name}")
    expect(page).to have_content("Quantity: #{invoice_item_1.quantity}")
    expect(page).to have_content("Price: #{invoice_item_1.unit_price}")
    expect(page).to have_content("Status: #{invoice_item_1.status}")

    expect(page).to have_content("Item: #{item_2.name}")
    expect(page).to have_content("Quantity: #{invoice_item_2.quantity}")
    expect(page).to have_content("Price: #{invoice_item_2.unit_price}")
    expect(page).to have_content("Status: #{invoice_item_2.status}")
  end

  it 'I see the total revenue that will be generated from this invoice' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 3, status: 2)

    visit admin_invoice_path(invoice_1.id)

    expect(page).to have_content("Total Revenue: #{invoice_1.total_revenue}")
  end

  it 'I can change invoice status using select field' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
    item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
    invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 3, status: 2)

    visit admin_invoice_path(invoice_1.id)
    select "Completed", :from => "invoice_status"

    click_button('Submit')
    expect(current_path).to eq(admin_invoice_path(invoice_1.id))
    expect(page).to have_content('Invoice Status: completed')
  end
end
