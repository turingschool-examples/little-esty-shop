require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page', type: :feature do
  it "visits the merchant invoices index and sees all invoices that include at least one of the merchant's items" do
    merchant_1 = Merchant.create(id: 1, name: "Pokemon Card Shop", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")
    merchant_2 = Merchant.create(id: 2, name: "Shoes Central", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    item_1 = Item.create(id: 1, merchant_id: merchant_1.id, name: "Charizard Rare", description: "Mint Condition Charizard", unit_price: 13984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_2 = Item.create(id: 2, merchant_id: merchant_1.id, name: "Charizard Common", description: "Average Condition Charizard", unit_price: 3984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_3 = Item.create(id: 3, merchant_id: merchant_1.id, name: "Charizard Poor", description: "Poor Condition Charizard", unit_price: 984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_4 = Item.create(id: 4, merchant_id: merchant_2.id, name: "Air Jordans", description: "New Air Jordan Shoes", unit_price: 84343, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")

    invoice_1 = Invoice.create(id: 10, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    invoice_2 = Invoice.create(id: 11, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    invoice_3 = Invoice.create(id: 12, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    invoice_4 = Invoice.create(id: 13, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")

    invoice_item_1 = InvoiceItem.create(id: 1, item_id: item_1.id, invoice_id: invoice_1.id, status: 'pending', quantity: 2, unit_price: 13984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_2 = InvoiceItem.create(id: 2, item_id: item_2.id, invoice_id: invoice_2.id, status: 'pending', quantity: 1, unit_price: 3984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_3 = InvoiceItem.create(id: 3, item_id: item_3.id, invoice_id: invoice_3.id, status: 'pending', quantity: 1, unit_price: 984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_4 = InvoiceItem.create(id: 4, item_id: item_4.id, invoice_id: invoice_4.id, status: 'pending', quantity: 1, unit_price: 84343, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")

    visit '/merchants/1/invoices'

    expect(page).to have_content("Pokemon Card Shop")
    expect(page).to have_content("Invoices")
    expect(page).to have_content("#{invoice_1.id}")
    expect(page).to have_content("#{invoice_2.id}")
    expect(page).to have_content("#{invoice_3.id}")
    expect(page).to have_no_content("#{invoice_4.id}")

  end
end


