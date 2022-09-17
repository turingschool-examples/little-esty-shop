require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  describe 'When I visit my merchants invoice show page(/merchants/merchant_id/invoices/invoice_id)' do
    describe 'Then I see information related to that invoice' do 
      it 'Invoice id, status, created_at date(Monday, July 18, 2019), Customer first/last name' do

        steph_merchant = Merchant.create!(name: "Stephen's shop")
        kev_merchant = Merchant.create!(name: "Kevin's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id) 
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id) 
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: kev_merchant.id) 

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice2.id)
        invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice3.id)

        visit merchant_invoice_path(steph_merchant, invoice1)

        expect(page).to have_content(invoice1.id)
        expect(page).to have_content(invoice1.status)
        expect(page).to have_content(invoice1.created_at.strftime('%A, %B %d, %Y'))
        expect(page).to have_content("Saturday, August 27, 2022")
        expect(page).to have_content(invoice1.customer.first_name)
        expect(page).to have_content(invoice1.customer.last_name)
      end
    end
  end
end