require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  describe 'User Story 15 - Merchant Invoice Show Page' do
    it 'When I visit my merchants show page, I see info related to that invoice
          including: invoice id, invoice status, invoice created_at date in format 
          Monday, July 18, 2019, and Customer first and last name' do 

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

        visit "/merchants/#{steph_merchant.id}/invoices/#{invoice1.id}"

        expect(page).to have_content("Invoice id: #{invoice1.id}")
        expect(page).to have_content("Status: #{invoice1.status}")
        expect(page).to have_content("#{customer1.first_name}")
        expect(page).to have_content("#{customer1.last_name}")
        expect(page).to_not have_content("Invoice id: #{invoice2.id}")
        expect(page).to_not have_content("Status: #{invoice2.status}")
        expect(page).to_not have_content("#{customer2.first_name}")
        expect(page).to_not have_content("#{customer2.last_name}")

    end
  end
end 