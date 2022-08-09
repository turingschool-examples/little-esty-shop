require 'rails_helper'

RSpec.describe 'Admin Invoices Show page' do
  describe 'invoice show reveals info related to invoice' do
    it 'shows an invoices specific info' do
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)

      visit "/admin/invoices/#{invoice_1.id}"

      created_at = invoice_1.created_at.strftime("%A, %B%e, %Y")

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content("Status: cancelled")
      expect(page).to have_content("Created at: #{invoice_1.created_at.strftime("%A, %B%e, %Y")}")
      expect(page).to have_content("David Smith")
    end

    it 'shows information + total revenue of all items under an invoice' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)

      item_1 = merchant_1.items.create!(name: "Log", description: "Wood, maple", unit_price: 500)
      item_2 = merchant_1.items.create!(name: "Saw", description: "Metal, sharp", unit_price: 700)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)

      visit "/admin/invoices/#{invoice_1.id}"

      expect(page).to have_content("Total Revenue: $60.00")

      within "#items-#{item_1.id}" do
        expect(page).to have_content("Item: Log")
        expect(page).to have_content("Quantity: #{invoice_item_1.quantity}")
        expect(page).to have_content("Price: $8.00")
        expect(page).to have_content("Status: pending")
        expect(page).to_not have_content("Status: packaged")
        expect(page).to_not have_content("item: Saw")
      end

      within "#items-#{item_2.id}" do
        expect(page).to have_content("Item: Saw")
        expect(page).to have_content("Quantity: #{invoice_item_2.quantity}")
        expect(page).to have_content("Price: $14.00")
        expect(page).to have_content("Status: packaged")
        expect(page).to_not have_content("Status: pending")
        expect(page).to_not have_content("Item: Log")
      end
    end

    it 'can update an invoices status' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)

      item_1 = merchant_1.items.create!(name: "Log", description: "Wood, maple", unit_price: 500)
      item_2 = merchant_1.items.create!(name: "Saw", description: "Metal, sharp", unit_price: 700)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)

      visit "/admin/invoices/#{invoice_1.id}"

      within "#items-#{item_1.id}" do
        expect(page).to have_select(:update_status, selected: "pending")
        select 'packaged', :from => :update_status
        click_on "Update Status"
        expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
        expect(page).to have_select(:update_status, selected: "packaged")
      end

      within "#items-#{item_2.id}" do
        expect(page).to have_select(:update_status, selected: "packaged")
        select 'shipped', :from => :update_status
        click_on "Update Status"
        expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
        expect(page).to have_select(:update_status, selected: "shipped")
      end
    end

    it 'shows the total revenue and discounted revenue for the invoice' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 700, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 900, merchant_id: merchant_1.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_3 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 10, unit_price: 100, status: 0, item_id: item_1.id, invoice_id: invoice_3.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 0, item_id: item_2.id, invoice_id: invoice_2.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 150, status: 0, item_id: item_3.id, invoice_id: invoice_3.id)

      discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 10)
      discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)

      visit "/admin/invoices/#{invoice_3.id}"

        expect(page).to have_content("Total Revenue: $14.50")
        expect(page).to have_content("Discounted Revenue: $13.50")
    end

  end
end
