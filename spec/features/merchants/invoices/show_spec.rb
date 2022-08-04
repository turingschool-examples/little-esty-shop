require 'rails_helper'

RSpec.describe 'merchants invoice show page', type: :feature do

  it "has all of the item info from an invoice" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant2.id)
    item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant3.id)

    customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
    invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice2 = Invoice.create!(status: "cancelled", customer_id: customer1.id)
    invoice3 = Invoice.create!(status: "in progress", customer_id: customer1.id)
    transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
    invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 2, unit_price: item2.unit_price, status: "pending", item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 3, unit_price: item3.unit_price, status: "packaged", item_id: item3.id, invoice_id: invoice3.id)

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    within "div#invoice" do
      expect(page).to have_content("Pikachu pics")
      expect(page).to have_content("shipped")
      expect(page).to have_content("Quantity: #{invoice_item1.quantity}")
      expect(page).to have_content("Price: #{invoice_item1.unit_price}")
      expect(page).to have_content("Status: #{invoice_item1.status}")
      expect(page).to_not have_content("Quantity: #{invoice_item2.quantity}")
      expect(page).to_not have_content("Price: #{invoice_item2.unit_price}")
      expect(page).to_not have_content("Status: #{invoice_item2.status}")
      expect(page).to_not have_content("Pokemon stuffy")
      expect(page).to_not have_content("Junk")
      expect(page).to_not have_content("pending")
      expect(page).to_not have_content("packaged")
    end

    visit "/merchants/#{merchant2.id}/invoices/#{invoice2.id}"

    within "div#invoice" do
      expect(page).to have_content("Pokemon stuffy")
      expect(page).to have_content("pending")
      expect(page).to have_content("Quantity: #{invoice_item2.quantity}")
      expect(page).to have_content("Price: #{invoice_item2.unit_price}")
      expect(page).to have_content("Status: #{invoice_item2.status}")
      expect(page).to_not have_content("Quantity: #{invoice_item3.quantity}")
      expect(page).to_not have_content("Price: #{invoice_item3.unit_price}")
      expect(page).to_not have_content("Status: #{invoice_item3.status}")
      expect(page).to_not have_content("Pikachu pics")
      expect(page).to_not have_content("Junk")
      expect(page).to_not have_content("shipped")
      expect(page).to_not have_content("packaged")
    end

    visit "/merchants/#{merchant3.id}/invoices/#{invoice3.id}"

    within "div#invoice" do
      expect(page).to have_content("Junk")
      expect(page).to have_content("packaged")
      expect(page).to have_content("Quantity: #{invoice_item3.quantity}")
      expect(page).to have_content("Price: #{invoice_item3.unit_price}")
      expect(page).to have_content("Status: #{invoice_item3.status}")
      expect(page).to_not have_content("Quantity: #{invoice_item1.quantity}")
      expect(page).to_not have_content("Price: #{invoice_item1.unit_price}")
      expect(page).to_not have_content("Status: #{invoice_item1.status}")
      expect(page).to_not have_content("Pikachu pics")
      expect(page).to_not have_content("Pokemon stuffy")
      expect(page).to_not have_content("pending")
      expect(page).to_not have_content("shipped")
    end
  end

  it "can list information related to a merchant's invoice" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant2.id)
    item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant3.id)

    customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
    invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice2 = Invoice.create!(status: "cancelled", customer_id: customer1.id)

    customer2 = Customer.create!(first_name: "Shirley", last_name: "DeCesari")
    invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice2 = Invoice.create!(status: "cancelled", customer_id: customer2.id)

    invoice3 = Invoice.create!(status: "in progress", customer_id: customer1.id)
    transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
    invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 2, unit_price: item2.unit_price, status: "pending", item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 3, unit_price: item3.unit_price, status: "packaged", item_id: item3.id, invoice_id: invoice3.id)

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    within "div#revenue" do
      expect(page).to have_content("Total Revenue: 1000")
      expect(page).to_not have_content("2000")
    end

    visit "/merchants/#{merchant2.id}/invoices/#{invoice2.id}"
    within "div#revenue" do
      expect(page).to have_content("Total Revenue: 4000")
      expect(page).to_not have_content("1000")
    end

    visit "/merchants/#{merchant3.id}/invoices/#{invoice3.id}"
    within "div#revenue" do
      expect(page).to have_content("Total Revenue: 1500")
      expect(page).to_not have_content("1000")
      expect(page).to_not have_content("4000")
    end

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

     within "#invoices-#{invoice1.id}" do
      expect(page).to have_content("Invoice id: #{invoice1.id}")
      expect(page).to have_content("Status: #{invoice1.status}")
      expect(page).to have_content("Customer: #{invoice1.customer.first_name} #{invoice1.customer.last_name}")
      expect(page).to_not have_content("#{invoice3.id}")
      expect(page).to_not have_content("#{invoice3.status}")
      expect(page).to_not have_content("Customer: #{invoice2.customer.first_name} #{invoice2.customer.last_name}")
    end

    visit "/merchants/#{merchant2.id}/invoices/#{invoice2.id}"

    within "#invoices-#{invoice2.id}" do
      expect(page).to have_content(invoice2.id)
      expect(page).to have_content("Status: #{invoice2.status}")
      expect(page).to have_content("Customer: #{invoice2.customer.first_name} #{invoice2.customer.last_name}")
      expect(page).to_not have_content("#{invoice1.id}")
      expect(page).to_not have_content("#{invoice1.status}")
      expect(page).to_not have_content("Customer: #{invoice1.customer.first_name} #{invoice1.customer.last_name}")
    end

    visit "/merchants/#{merchant3.id}/invoices/#{invoice3.id}"

    within "#invoices-#{invoice3.id}" do
      expect(page).to have_content(invoice3.id)
      expect(page).to have_content("Status: #{invoice3.status}")
      expect(page).to have_content("Customer: #{invoice3.customer.first_name} #{invoice3.customer.last_name}")
      expect(page).to_not have_content("#{invoice2.id}")
      expect(page).to_not have_content("#{invoice2.status}")
      expect(page).to_not have_content("Customer: #{invoice2.customer.first_name} #{invoice2.customer.last_name}")
    end
  end

  it "can update an item's status" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
    invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "pending", item_id: item1.id, invoice_id: invoice1.id)

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    expect(page).to have_field(:status, with: "Pending")
    select 'Packaged', from: :status
    click_on "Update Item Status"
    expect(current_path).to eq("/merchants/#{merchant1.id}/invoices/#{invoice1.id}")

    expect(page).to have_field(:status, with: "Packaged")
    select 'Shipped', from: :status
    click_on "Update Item Status"
    expect(current_path).to eq("/merchants/#{merchant1.id}/invoices/#{invoice1.id}")
    expect(page).to have_field(:status, with: "Shipped")
  end
end
