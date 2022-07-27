require 'rails_helper'

RSpec.describe 'merchant_invoices show page' do
  it 'shows invoice details: id, status,customer name, created_at in Monday, July 18, 2019 format' do
      merch1 = Merchant.create!(name: 'Needful Things Imports')

      customer1 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
      customer2 = Customer.create!(first_name: 'Veruca', last_name: 'Salt')

      item1 = merch1.items.create!(name: 'Phoenix Feather Wand', description: 'Ergonomic grip', unit_price: 20)
      item2 = merch1.items.create!(name: 'Harmonica', description: 'Makes pretty noise', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 20, status: 1)

      visit merchant_invoice_path(merch1.id, invoice1.id)

      within('#invoice-details') do
        expect(page).to have_content("ID: #{invoice1.id}")
        expect(page).to have_content("Status: #{invoice1.status}")
        expect(page).to have_content("Created: #{invoice1.formatted_date}")
        expect(page).to have_content("Customer: #{invoice1.customer_name}")
        expect(page).to_not have_content("ID: #{invoice2.id}")
      end
  end
end