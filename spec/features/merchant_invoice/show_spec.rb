require 'rails_helper'

RSpec.describe "Merchant Invoice Show" do
  it 'shows all invoice items' do
    merchant1 = Merchant.create!(name: "Bob's Burgers")
    customer1 = Customer.create!(first_name: "Teddy", last_name: "Lastname")
    invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)
    item1 = Item.create!(name: "Burger", description: "Burger with fries", unit_price: 3, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Shake", description: "Shake without fries", unit_price: 2, merchant_id: merchant1.id)
    invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price, status: 0)
    invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: item2.unit_price, status: 0)

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
    invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price, status: 0)
    invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: item2.unit_price, status: 0)

    visit "merchants/#{merchant1.id}/invoices/#{invoice1.id}"

    expect(page).to have_content("Total Revenue: 13")
  end

  it "can update the invoice item's status" do
      merchant1 = Merchant.create!(name: "Bob's Burgers")
      customer1 = Customer.create!(first_name: "Teddy", last_name: "Lastname")
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)
      item1 = Item.create!(name: "Burger", description: "Burger with fries", unit_price: 3, merchant_id: merchant1.id)
      item2 = Item.create!(name: "Shake", description: "Shake without fries", unit_price: 2, merchant_id: merchant1.id)
      invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price, status: 0)
      invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: item2.unit_price, status: 0)

      visit "merchants/#{merchant1.id}/invoices/#{invoice1.id}"
      save_and_open_page
      click_button "Update Item Status"

      reload item1
      expect(item1.status).to eq(1)
  end
end

# As a merchant
# When I visit my merchant invoice show page
# I see that each invoice item status is a select field
# And I see that the invoice item's current status is selected
# When I click this select field,
# Then I can select a new status for the Item,
# And next to the select field I see a button to "Update Item Status"
# When I click this button
# I am taken back to the merchant invoice show page
# And I see that my Item's status has now been updated
