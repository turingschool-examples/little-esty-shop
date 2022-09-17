require "rails_helper"


RSpec.describe "the merchant items index"  do
    it "I see the name of my merchants index page"  do
        merchant1 = Merchant.create!(name: "Bob")

        visit "/merchants/#{merchant1.id}/invoices"
        expect(page).to have_content("#{merchant1.name} Invoices")
    end

    it 'I can see the invoices that are asscoiated with the merchant' do
        merchant1 = Merchant.create!(name: "Bob")
        customer1 = Customer.create!(first_name: "Jolene", last_name: "Jones")
        invoice_1 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
        invoice_2 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:02")
        invoice_3 = customer1.invoices.create!(status: 1, created_at: "2021-09-14 09:00:03")
        item1 = merchant1.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
        item2 = merchant1.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
        item3 = merchant1.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice_1.id, unit_price: item1.unit_price, quantity: 1, status: 0)
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice_2.id, unit_price: item2.unit_price, quantity: 2, status: 0)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice_3.id, unit_price: item3.unit_price, quantity: 3, status: 0)

        merchant2 = Merchant.create!(name: "Bob")
        customer2 = Customer.create!(first_name: "Jolene", last_name: "Jones")
        invoice_4 = customer2.invoices.create!(status: 1, created_at: "2021-09-14 09:00:01")
        invoice_5 = customer2.invoices.create!(status: 1, created_at: "2021-09-14 09:00:02")
        invoice_6 = customer2.invoices.create!(status: 1, created_at: "2021-09-14 09:00:03")
        item4 = merchant2.items.create!(name: "item1", description: "this is item1 description", unit_price: 1)
        item5 = merchant2.items.create!(name: "item2", description: "this is item2 description", unit_price: 2)
        item6 = merchant2.items.create!(name: "item3", description: "this is item3 description", unit_price: 3)
        invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice_4.id, unit_price: item4.unit_price, quantity: 1, status: 0)
        invoice_item5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice_5.id, unit_price: item5.unit_price, quantity: 2, status: 0)
        invoice_item6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice_6.id, unit_price: item6.unit_price, quantity: 3, status: 0)

        visit "/merchants/#{merchant1.id}/invoices"

        expect(page).to have_content("Invoice: #{invoice_1.id}")
        expect(page).to have_content("Invoice: #{invoice_2.id}")
        expect(page).to have_content("Invoice: #{invoice_3.id}")

        expect(page).to_not have_content("Invoice: #{invoice_4.id}")
        expect(page).to_not have_content("Invoice: #{invoice_5.id}")
        expect(page).to_not have_content("Invoice: #{invoice_6.id}")
    end
end