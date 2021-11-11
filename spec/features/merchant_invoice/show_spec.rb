require 'rails_helper'

RSpec.describe "Merchant Invoice Show" do
  it 'shows all invoice items' do
    merchant1 = Merchant.create!(name: "Bob's Burgers")
    customer1 = Customer.create!(first_name: "Teddy", last_name: "Lastname")
    invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)
    item1 = Item.create!(name: "Burger", description: "Burger with fries", unit_price: 3, merchant_id: merchant1.id)
    invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price, status: "Packaged")

    visit "merchants/#{merchant1.id}/invoices/#{invoice1.id}"


    expect(page).to have_content(item1.name)
    expect(page).to have_content(invoiceitem1.quantity)
    expect(page).to have_content(invoiceitem1.unit_price)
    expect(page).to have_content(invoiceitem1.status)
  end

  it 'can show total revenue for the invoice' do
    merchant1 = Merchant.create!(name: "Bob's Burgers")
    customer1 = Customer.create!(first_name: "Teddy", last_name: "Lastname")
    invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)
    item1 = Item.create!(name: "Burger", description: "Burger with fries", unit_price: 3, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Shake", description: "Shake without fries", unit_price: 2, merchant_id: merchant1.id)
    invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price, status: "Packaged")
    invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: item2.unit_price, status: "Pending")

    visit "merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    expect(page).to have_content("Total Revenue: 13")
  end

  it "can update the invoice item's status" do
    merchant1 = Merchant.create!(name: "Bob's Burgers")
    customer1 = Customer.create!(first_name: "Teddy", last_name: "Lastname")
    invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)
    item1 = Item.create!(name: "Burger", description: "Burger with fries", unit_price: 3, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Shake", description: "Shake without fries", unit_price: 2, merchant_id: merchant1.id)
    invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price, status: "Packaged")
    invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: item2.unit_price, status: "Pending")

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    within "#id-#{invoiceitem1.id}" do
      select "Pending", from: "Status"
      click_button "Update Item Status"
    end

    within "#id-#{invoiceitem2.id}" do
      select "Shipped", from: "Status"
      click_button "Update Item Status"
    end

    invoiceitem1.reload
    invoiceitem2.reload
    expect(invoiceitem1.status).to eq("Pending")
    expect(invoiceitem2.status).to eq("Shipped")
    end
  end
