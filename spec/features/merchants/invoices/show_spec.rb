require 'rails_helper'

RSpec.describe 'Merchant Invoices Show Page' do
  it 'has displays invoice id, invoice status, invoice_created at, and customers first and last name' do
  merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
  merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
  merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

  item1 = Item.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344, merchant_id: merchant1.id)
  item2 = Item.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334, merchant_id: merchant1.id)
  item3 = Item.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839, merchant_id: merchant1.id)
  item4 = Item.create!(name: 'football', description: 'sports', unit_price: 299839, merchant_id: merchant1.id)

  customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')
  customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
  customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
  customer4 = Customer.create!(first_name: 'Jim', last_name: 'Bob')

  invoice1 = customer1.invoices.create!(status: 2)
  invoice2 = customer2.invoices.create!(status: 2)
  invoice3 = customer3.invoices.create!(status: 2)
  invoice4 = customer4.invoices.create!(status: 2)

  invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 2)
  invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 2)
  invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)
  invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)

  visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

  expect(current_path).to eq("/merchants/#{merchant1.id}/invoices/#{invoice1.id}")
  expect(page).to have_content("#{invoice1.id}")
  expect(page).to have_content("completed")
  expect(page).to have_content("#{invoice1.created_at.strftime('%A, %B %d, %Y')}")
  expect(page).to have_content("Bob Smith")
  end

  it 'has provides item information' do

    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = Item.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839, merchant_id: merchant1.id)
    item4 = Item.create!(name: 'football', description: 'sports', unit_price: 299839, merchant_id: merchant1.id)

    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')
    customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
    customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
    customer4 = Customer.create!(first_name: 'Jim', last_name: 'Bob')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer2.invoices.create!(status: 2)
    invoice3 = customer3.invoices.create!(status: 2)
    invoice4 = customer4.invoices.create!(status: 2)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 2)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 87654, status: 2)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)
    invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    expect(current_path).to eq("/merchants/#{merchant1.id}/invoices/#{invoice1.id}")
    expect(page).to have_content("Name: Coaster")
    expect(page).to have_content("Quantity: 4")
    expect(page).to have_content("Price: $743.44")
    expect(page).to have_content("Status: shipped")
    expect(page).to_not have_content("knife")
  end

  it 'has a total revenue generated from all items on the invoice' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = Item.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839, merchant_id: merchant1.id)
    item4 = Item.create!(name: 'football', description: 'sports', unit_price: 299839, merchant_id: merchant1.id)

    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')
    customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
    customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
    customer4 = Customer.create!(first_name: 'Jim', last_name: 'Bob')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer2.invoices.create!(status: 2)
    invoice3 = customer3.invoices.create!(status: 2)
    invoice4 = customer4.invoices.create!(status: 2)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 2)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 87654, status: 2)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)
    invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)

    visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    expect(page).to have_content('$6,120.06')
  end
end
