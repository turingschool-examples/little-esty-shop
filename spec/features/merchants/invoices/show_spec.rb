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
            expect(page).to have_content(invoice_1.status)
            expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d, %Y"))
            expect(page).to have_content("#{customer.first_name} #{customer.last_name}")
        end
    end
end