require 'rails_helper'

RSpec.describe 'the merchant dashboard' do
  it 'shows the name of the merchant' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content('Fake Merchant')
  end

  it 'has a link to the merchants items index and merchant invoices index' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(current_path).to eq("/merchants/#{merchant1.id}/dashboard")
    expect(page).to have_link("Merchant Items Index")
    expect(page).to have_link("Merchant Invoices Index")
  end

    it 'has a section for items ready to ship' do
      merchant1 = Merchant.create!(name: 'Fake Merchant')
      merchant2 = Merchant.create!(name: 'Also fake Merchant')

      item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
      item2 = merchant2.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
      item3 = merchant2.items.create!(name: 'Cutting board', description: 'kitchen essential', unit_price: 28839)
      customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')
      customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
      customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')

      invoice1 = customer1.invoices.create!(status: 'cancelled')
      invoice2 = customer1.invoices.create!(status: 'completed')
      invoice3 = customer1.invoices.create!(status: 'in progress')

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 'pending')
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 'shipped')
      invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 'packaged')

      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_content("Items Ready to Ship:")
      expect(page).to have_content("#{item1.name}")
      expect(page).to_not have_content("#{item2.name}")
    end
  end
