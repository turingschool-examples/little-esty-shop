require 'rails_helper'

RSpec.describe "admin invoice show page" do
  it "shows information related to that invoice - id, status, created_at, customer first/last name" do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')

    item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
    item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
    item3 = merchant1.items.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839)

    customer1 = Customer.create!(first_name: 'Robert', last_name: 'Smith')
    customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
    customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
    customer4 = Customer.create!(first_name: 'Jimmy', last_name: 'Ray')
    customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
    customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')
    customer7 = Customer.create!(first_name: 'Not', last_name: 'Goodenough')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer1.invoices.create!(status: 2)
    invoice3 = customer2.invoices.create!(status: 2)
    invoice4 = customer2.invoices.create!(status: 2)
    invoice5 = customer2.invoices.create!(status: 2)

    visit "/admin/invoices/#{invoice1.id}"

    expect(page).to have_content("#{invoice1.id}")
    expect(page).to have_content("#{invoice1.status}")
    expect(page).to have_content(invoice1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content("Robert Smith")
    expect(page).to_not have_content("#{invoice2.id}")
    expect(page).to_not have_content("Suzie Hill")
  end

  it "has all of the items on the invoice, including item name, qty, price, invoice_item status" do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')

    item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
    item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
    item3 = merchant1.items.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839)

    customer1 = Customer.create!(first_name: 'Robert', last_name: 'Smith')
    customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
    customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
    customer4 = Customer.create!(first_name: 'Jimmy', last_name: 'Ray')
    customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
    customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer1.invoices.create!(status: 2)
    invoice3 = customer2.invoices.create!(status: 2)
    invoice4 = customer2.invoices.create!(status: 2)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 8, unit_price: 43434, status: 2)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 1)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)

    visit "/admin/invoices/#{invoice1.id}"

    expect(page).to have_content("Coaster")
    expect(page).to have_content("8")
    expect(page).to have_content("74344")
    expect(page).to have_content("shipped")
    expect(page).to_not have_content("Tongs")
    expect(page).to_not have_content("Packaged")
  end

  it "has the total revenue generated from this invoice" do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')

    item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
    item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
    item3 = merchant1.items.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839)

    customer1 = Customer.create!(first_name: 'Robert', last_name: 'Smith')
    customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
    customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
    customer4 = Customer.create!(first_name: 'Jimmy', last_name: 'Ray')
    customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
    customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer1.invoices.create!(status: 2)
    invoice3 = customer2.invoices.create!(status: 2)
    invoice4 = customer2.invoices.create!(status: 2)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 8, unit_price: 43434, status: 2)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 1)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)

    visit "/admin/invoices/#{invoice1.id}"

    expect(page).to have_content("347472")
  end
end

# As an admin
# When I visit an admin invoice show page
# Then I see the total revenue that will be generated from this invoice
