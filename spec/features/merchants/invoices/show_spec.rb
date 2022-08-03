require 'rails_helper'

RSpec.describe "invoice showpage" do
  describe "showpage" do
    it "can display the invoice information" do

      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Billy West", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

      customer1 = Customer.create!(first_name: "Susan", last_name: "Sarandon", created_at: Time.now, updated_at: Time.now)

      invoice1 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer1.id)

      invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, created_at: Time.now, updated_at: Time.now, quantity: 2, unit_price: 2, status: 1)
      invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, created_at: Time.now, updated_at: Time.now, quantity: 2, unit_price: 2, status: 1)
      invoiceitem3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, created_at: Time.now, updated_at: Time.now, quantity: 1, unit_price: 2, status: 1)

      visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"
      # binding.pry
      # save_and_open_page
      expect(page).to have_content("Invoice #{invoice1.id}")
      expect(page).to have_content("#{invoice1.status}")
      expect(page).to have_content("#{invoice1.created_at.strftime('%A, %B %-d, %Y')}")
      expect(page).to have_content("#{customer1.first_name} #{customer1.last_name}")
    end
    it "can display the items" do

      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Billy West", created_at: Time.now, updated_at: Time.now)

      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

      customer1 = Customer.create!(first_name: "Susan", last_name: "Sarandon", created_at: Time.now, updated_at: Time.now)

      invoice1 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer1.id)
      invoice2 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: customer1.id)

      invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, created_at: Time.now, updated_at: Time.now, quantity: 2, unit_price: 200, status: 1)
      invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, created_at: Time.now, updated_at: Time.now, quantity: 3, unit_price: 400, status: 1)
      invoiceitem3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, created_at: Time.now, updated_at: Time.now, quantity: 1, unit_price: 2, status: 1)

      visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"
      save_and_open_page
      expect(page).to have_content("#{item1.name}")
      expect(page).to have_content("#{item1.unit_price}")
    end
  end
end
