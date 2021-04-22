require 'rails_helper'

RSpec.describe 'the merchant invoice index', type: :feature do

  it 'it displays all invoices with items from one merchant: '  do
    merchant = Merchant.create(name: 'Bob Cella')
    merchant_2 = Merchant.create(name: 'dud duddly')

    item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
    item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
    item_c = merchant.items.create!(name: "coool", description: "yo", unit_price: 200)
    item_d = merchant_2.items.create!(name: "doo-hicky", description: "stuffy stuff", unit_price: 200)

    customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
    customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

    invoice_1 = customer_a.invoices.create!(status: 0)
    invoice_2 = customer_b.invoices.create!(status: 0)
    invoice_3 = customer_a.invoices.create!(status: 0)

    invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice_1.id, item_id: item_a.id)
    invoice_item_1b = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice_1.id, item_id: item_b.id)
    invoice_item_1c = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice_1.id, item_id: item_c.id)

    invoice_item_2a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice_2.id, item_id: item_a.id)
    invoice_item_2b = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice_2.id, item_id: item_b.id)
    invoice_item_2d = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice_2.id, item_id: item_d.id)

    invoice_item_3d = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice_3.id, item_id: item_d.id)

    visit "merchants/#{merchant.id}/invoices"

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_2.id)
  end

  it 'it displays links to invoice show page: '  do
    merchant = Merchant.create(name: 'Bob Cella')
    merchant_2 = Merchant.create(name: 'dud duddly')

    item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
    item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
    item_c = merchant.items.create!(name: "coool", description: "yo", unit_price: 200)
    item_d = merchant_2.items.create!(name: "doo-hicky", description: "stuffy stuff", unit_price: 200)

    customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
    customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

    invoice_1 = customer_a.invoices.create!(status: 0)
    invoice_2 = customer_b.invoices.create!(status: 0)
    invoice_3 = customer_a.invoices.create!(status: 0)

    invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice_1.id, item_id: item_a.id)
    invoice_item_1b = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice_1.id, item_id: item_b.id)
    invoice_item_1c = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice_1.id, item_id: item_c.id)

    invoice_item_2a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice_2.id, item_id: item_a.id)
    invoice_item_2b = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice_2.id, item_id: item_b.id)
    invoice_item_2d = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice_2.id, item_id: item_d.id)

    invoice_item_3d = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice_3.id, item_id: item_d.id)

    visit "/merchants/#{merchant.id}/invoices"

    expect(page).to have_link(invoice_1.id)
    expect(page).to have_link(invoice_2.id)
    expect(current_path).to eq("/merchants/#{merchant.id}/invoices")

    click_link("#{invoice_1.id}")

    expect(current_path).to eq("/merchants/#{merchant.id}/invoices/#{invoice_1.id}")
  end
end
