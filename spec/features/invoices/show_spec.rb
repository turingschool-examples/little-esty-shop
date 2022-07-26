require 'rails_helper'

RSpec.describe 'Invoice Show', type: :feature do
  it 'shows the invoice and the invoice information' do
    merchant_1 = Merchant.create!(id: 1, name: "Pokemon Card Shop", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    item_1 = merchant_1.items.create!(id: 1, merchant_id: merchant_1.id, name: "Charizard Rare", description: "Mint Condition Charizard", unit_price: 13984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_2 = merchant_1.items.create!(id: 2, merchant_id: merchant_1.id, name: "Charizard Common", description: "Average Condition Charizard", unit_price: 3984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")

    customer_1 = Customer.create!(id: 1, first_name: "John", last_name: "Doe", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    invoice_1 = customer_1.invoices.create!(id: 10, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)
    invoice_2 = customer_1.invoices.create!(id: 11, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)

    invoice_item_1 = InvoiceItem.create!(id: 1, item_id: item_1.id, invoice_id: invoice_1.id, status: 'pending', quantity: 2, unit_price: 13984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_2 = InvoiceItem.create!(id: 2, item_id: item_2.id, invoice_id: invoice_2.id, status: 'pending', quantity: 1, unit_price: 3984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")

    visit '/merchants/1/invoices/10'

    expect(page).to have_content("10")
    expect(page).to have_content("in progress")
    expect(page).to have_content("Wednesday, March, 27, 2013")
    expect(page).to have_content("John")
    expect(page).to have_content("Doe")
    expect(page).to have_no_content("11")
  end

  it 'shows the invoice item information including item name, quantity, price, and status' do
    merchant_1 = Merchant.create!(id: 1, name: "Pokemon Card Shop", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    item_1 = merchant_1.items.create!(id: 1, merchant_id: merchant_1.id, name: "Charizard Rare", description: "Mint Condition Charizard", unit_price: 13984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_2 = merchant_1.items.create!(id: 2, merchant_id: merchant_1.id, name: "Charizard Common", description: "Average Condition Charizard", unit_price: 3984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_3 = merchant_1.items.create!(id: 3, merchant_id: merchant_1.id, name: "Charizard Poor", description: "Poor Condition Charizard", unit_price: 3984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")

    customer_1 = Customer.create!(id: 1, first_name: "John", last_name: "Doe", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    invoice_1 = customer_1.invoices.create!(id: 10, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)
    invoice_2 = customer_1.invoices.create!(id: 11, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)

    invoice_item_1 = InvoiceItem.create!(id: 1, item_id: item_1.id, invoice_id: invoice_1.id, status: 'pending', quantity: 3, unit_price: 13984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_2 = InvoiceItem.create!(id: 2, item_id: item_2.id, invoice_id: invoice_1.id, status: 'pending', quantity: 2, unit_price: 3984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_3 = InvoiceItem.create!(id: 3, item_id: item_3.id, invoice_id: invoice_2.id, status: 'pending', quantity: 1, unit_price: 3984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")

    visit '/merchants/1/invoices/10'

    within "#item_invoice-#{invoice_item_1.id}" do
      expect(page).to have_content("Charizard Rare")
      expect(page).to have_content("3")
      expect(page).to have_content("$13,984.00")
      expect(page).to have_content("pending")
    end

    within "#item_invoice-#{invoice_item_2.id}" do
      expect(page).to have_content("Charizard Common")
      expect(page).to have_content("2")
      expect(page).to have_content("$3,984.00")
      expect(page).to have_content("pending")
    end

    expect(page).to have_no_content("Charizard Poor")
  end

  it 'calculates the total revenue from all items on the invoice' do
    merchant_1 = Merchant.create!(id: 1, name: "Pokemon Card Shop", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    item_1 = merchant_1.items.create!(id: 1, merchant_id: merchant_1.id, name: "Charizard Rare", description: "Mint Condition Charizard", unit_price: 13984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_2 = merchant_1.items.create!(id: 2, merchant_id: merchant_1.id, name: "Charizard Common", description: "Average Condition Charizard", unit_price: 3984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_3 = merchant_1.items.create!(id: 3, merchant_id: merchant_1.id, name: "Charizard Poor", description: "Poor Condition Charizard", unit_price: 1230, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")

    customer_1 = Customer.create!(id: 1, first_name: "John", last_name: "Doe", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    invoice_1 = customer_1.invoices.create!(id: 10, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)
    invoice_2 = customer_1.invoices.create!(id: 11, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)

    invoice_item_1 = InvoiceItem.create!(id: 1, item_id: item_1.id, invoice_id: invoice_1.id, status: 'pending', quantity: 3, unit_price: 13984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_2 = InvoiceItem.create!(id: 2, item_id: item_2.id, invoice_id: invoice_1.id, status: 'pending', quantity: 2, unit_price: 3984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_3 = InvoiceItem.create!(id: 3, item_id: item_3.id, invoice_id: invoice_2.id, status: 'pending', quantity: 1, unit_price: 3984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")

    visit '/merchants/1/invoices/10'

    expect(page).to have_content("Total Revenue: $49,920.00")
    expect(page).to have_no_content("Total Revenue: $12.30")
  end
end