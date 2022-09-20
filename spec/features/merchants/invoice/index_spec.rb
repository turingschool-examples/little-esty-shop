require 'rails_helper'

RSpec.describe 'Merchant Invoice Index Page' do
  describe 'User Story 14 - Merchant Invoice Index Page' do

    it 'When I visit page, I see all of the invoice id that include at least one of my merchants items' do 

      steph_merchant = Merchant.create!(name: "Stephen's shop")

      customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")
      customer2 = Customer.create!(first_name: "Bill", last_name: "Gates")

      item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id) 
      item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id) 
      item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id) 

      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
      invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

      invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
      invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice2.id)

      visit merchant_invoices_path(steph_merchant)
      expect(page).to have_content("#{steph_merchant.name}")
      expect(page).to have_content("My Invoices")
      expect(page).to have_content("Invoice ##{invoice1.id}")
      expect(page).to have_content("Invoice ##{invoice2.id}")
    end

    it 'And each id links to the merchant invoice show page' do 

      steph_merchant = Merchant.create!(name: "Stephen's shop")

      customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")
      customer2 = Customer.create!(first_name: "Bill", last_name: "Gates")

      item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id) 
      item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id) 
      item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: steph_merchant.id) 

      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
      invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

      invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
      invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice2.id)

      visit merchant_invoices_path(steph_merchant)
      click_link("Invoice ##{invoice1.id}")
      expect(current_path).to eq(merchant_invoice_path(steph_merchant, invoice1))
    end
  end
end
