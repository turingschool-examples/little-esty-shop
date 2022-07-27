require 'rails_helper'

RSpec.describe 'Merchant invoice Index page' do
    it 'shows a list of all invoices associated with a merchant' do
        merchant = Merchant.create!(name: 'amazon')
        merchant_2 = Merchant.create!(name: 'amazon')
        customer = Customer.create!(first_name: 'Billy', last_name: 'Bob')
        item_1 = Item.create!(name: 'pet rock', description: 'a rock you pet', unit_price: 10000, merchant_id: merchant.id)
        item_2 = Item.create!(name: 'ferbie', description: 'monster toy', unit_price: 66600, merchant_id: merchant.id)
        item_3 = Item.create!(name: 'bay blade', description: 'let it rip!', unit_price: 23400, merchant_id: merchant_2.id)
        invoice_1 = Invoice.create!(status: 'completed', customer_id: customer.id)
        invoice_2 = Invoice.create!(status: 'completed', customer_id: customer.id)
        invoice_3 = Invoice.create!(status: 'completed', customer_id: customer.id)

        InvoiceItem.create!(quantity: 2, unit_price: 12345, status: 'shipped', item: item_1, invoice: invoice_1)
        InvoiceItem.create!(quantity: 2, unit_price: 12345, status: 'shipped', item: item_2, invoice: invoice_1)
        InvoiceItem.create!(quantity: 2, unit_price: 12345, status: 'shipped', item: item_1, invoice: invoice_2)
        InvoiceItem.create!(quantity: 2, unit_price: 12345, status: 'shipped', item: item_3, invoice: invoice_3)

        visit "/merchants/#{merchant.id}/invoices"

        within "#invoice-#{invoice_1.id}" do
            expect(page).to have_content(invoice_1.id)
            expect(page).to_not have_content(invoice_2.id)
        end

        within "#invoice-#{invoice_2.id}" do
            expect(page).to have_content(invoice_2.id)
            expect(page).to_not have_content(invoice_1.id)
        end

        expect(page).to_not have_content(invoice_3.id)
    end

    
end