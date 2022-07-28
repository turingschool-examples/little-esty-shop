require 'rails_helper'

RSpec.describe 'Merchant invoice Show page' do
    it 'displays id/status/created_at/customer_name ' do
        merchant = Merchant.create!(name: 'amazon')
        customer = Customer.create!(first_name: 'Billy', last_name: 'Bob')
        item_1 = Item.create!(name: 'pet rock', description: 'a rock you pet', unit_price: 10000, merchant_id: merchant.id)
        invoice_1 = Invoice.create!(status: 'completed', customer_id: customer.id)
        invoice_2 = Invoice.create!(status: 'in progress', customer_id: customer.id)

        InvoiceItem.create!(quantity: 2, unit_price: 12345, status: 'shipped', item: item_1, invoice: invoice_1)
        InvoiceItem.create!(quantity: 2, unit_price: 12345, status: 'shipped', item: item_1, invoice: invoice_2)

        visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"

        within "#invoice-details" do
            expect(page).to have_content(invoice_1.id)
            expect(page).to have_content('completed')
            expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d, %Y"))
            expect(page).to have_content("Billy Bob")

            expect(page).to_not have_content(invoice_2.id)
            expect(page).to_not have_content('in progress')
        end
    end

    it 'displays item name/quantity/price/invoice_item status ' do
        merchant = Merchant.create!(name: 'amazon')
        merchant_2 = Merchant.create!(name: 'Gucci')
        customer = Customer.create!(first_name: 'Billy', last_name: 'Bob')
        item_1 = Item.create!(name: 'pet rock', description: 'a rock you pet', unit_price: 10000, merchant_id: merchant.id)
        item_2 = Item.create!(name: 'ferbie', description: 'monster toy', unit_price: 66600, merchant_id: merchant.id)
        item_3 = Item.create!(name: 'bay blade', description: 'let it rip!', unit_price: 23400, merchant_id: merchant_2.id)
        invoice_1 = Invoice.create!(status: 'completed', customer_id: customer.id)
        invoice_2 = Invoice.create!(status: 'in progress', customer_id: customer.id)

        InvoiceItem.create!(quantity: 2121, unit_price: 12345, status: 'shipped', item: item_1, invoice: invoice_1)
        InvoiceItem.create!(quantity: 234, unit_price: 2353456, status: 'packaged', item: item_2, invoice: invoice_1)
        InvoiceItem.create!(quantity: 2345, unit_price: 2353, status: 'packaged', item: item_3, invoice: invoice_1)
        InvoiceItem.create!(quantity: 321, unit_price: 3254, status: 'shipped', item: item_1, invoice: invoice_2)

        visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"

        within "#item-details" do
            expect(page).to have_content('pet rock')
            expect(page).to have_content("2121")
            expect(page).to have_content("$123.45")
            expect(page).to have_content("shipped")

            expect(page).to_not have_content('bay blade')
        end
    end

    it 'shows total revenue generated from all items on invoice' do
        merchant = Merchant.create!(name: 'amazon')
        customer = Customer.create!(first_name: 'Billy', last_name: 'Bob')
        item_1 = Item.create!(name: 'pet rock', description: 'a rock you pet', unit_price: 10000, merchant_id: merchant.id)
        item_2 = Item.create!(name: 'ferbie', description: 'monster toy', unit_price: 66600, merchant_id: merchant.id)
        invoice_1 = Invoice.create!(status: 'completed', customer_id: customer.id)


        InvoiceItem.create!(quantity: 2, unit_price: 11, status: 'shipped', item: item_1, invoice: invoice_1)
        InvoiceItem.create!(quantity: 10, unit_price: 500, status: 'packaged', item: item_2, invoice: invoice_1)

        visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"

        within "#invoice-details" do
            expect(page).to have_content("Total Revenue: $50.22")
        end
    end
end