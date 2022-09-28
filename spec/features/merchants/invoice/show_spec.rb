require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  before :each do
    names_array = {'gjcarew' => 22, 'stephenfabian' => 25, 'Rileybmcc' => 22, 'KevinT001' => 11}
    allow(GithubFacade).to receive(:commits).and_return(names_array)

    pull_requests_count = 3
    allow(GithubFacade).to receive(:pull_requests).and_return(pull_requests_count)
  end
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

  describe 'Merchant Invoice Show Page: Invoice Item Information' do
    describe 'When I visit my merchant invoice show page' do
      it 'Then I see all of my items on  invoice including: item name, qty of the item ordered, price item sold for, the Invoice Item status' do

        steph_merchant = Merchant.create!(name: "Stephen's shop")
        kev_merchant = Merchant.create!(name: "Kevin's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: kev_merchant.id)

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "packaged", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity:90, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice3.id)

        visit merchant_invoice_path(steph_merchant, invoice1)

        within"#item_#{item1.id}" do
          expect(page).to have_content(item1.name)
          expect(page).to have_content(invoice_item1.quantity)
          expect(page).to have_content("$15.00")
          expect(page).to have_content("Packaged")
        end

        within"#item_#{item2.id}" do
          expect(page).to have_content(item2.name)
          expect(page).to have_content(invoice_item2.quantity)
          expect(page).to have_content("$25.00")
          expect(page).to have_content("Packaged")
        end
# save_and_open_page
        expect(page).to_not have_content(item3.name)
        expect(page).to_not have_content(invoice_item3.unit_price)
        expect(page).to_not have_content(invoice_item3.status)
      end
    end
  end

  describe 'Merchant Invoice Show Page: Total Revenue' do
    describe 'When I visit my merchant invoice show page' do
      it 'I see the total revenue that will be generated from all of my items on the invoice' do
        steph_merchant = Merchant.create!(name: "Stephen's shop")
        kev_merchant = Merchant.create!(name: "Kevin's shop")

        customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

        item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
        item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
        item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: kev_merchant.id)

        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
        invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

        invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "packaged", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity:90, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice3.id)

        visit merchant_invoice_path(steph_merchant, invoice1)
        expect(page).to have_content("$4,000.00")
      end
    end
  end

  describe 'When I visit my merchant invoice show page' do
    describe 'I see that each invoice item status is a select field' do
      describe 'And I see that the invoice items current status is selected' do
        it 'When I select new status and click submit button, redirected to merchant invoice show, and item status is updated' do

          steph_merchant = Merchant.create!(name: "Stephen's shop")
          kev_merchant = Merchant.create!(name: "Kevin's shop")

          customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

          item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id)
          item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id)
          item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: kev_merchant.id)

          invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
          invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
          invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

          invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "packaged", item_id: item1.id, invoice_id: invoice1.id)
          invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
          invoice_item3 = InvoiceItem.create!(quantity:90, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice3.id)

          visit merchant_invoice_path(steph_merchant, invoice1)

          within("#item_#{item1.id}") do
            select "Shipped", from: "status"
            click_button "Update Item Status"

            expect(current_path).to eq(merchant_invoice_path(steph_merchant, invoice1))
            expect(invoice_item1.reload.status).to eq("shipped")
          end

          within("#item_#{item2.id}") do
            select "Shipped", from: "status"
            click_button "Update Item Status"

            expect(current_path).to eq(merchant_invoice_path(steph_merchant, invoice1))
            expect(invoice_item2.reload.status).to eq("shipped")
          end

        end
      end
    end
  end
end
