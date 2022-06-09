require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page', type: :feature do
  let!(:merchant1) { create(:merchant) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }

  let!(:customer1) { create(:customer) }

  let!(:invoice1) { create(:invoice, customer: customer1, status: 0) }

  let!(:transaction1) { create(:transaction, invoice: invoice1, result: 1) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011) }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524) }
  it 'lists invoice attributes' do
    visit "/admin/invoices/#{invoice1.id}"
    # expect(page).to have_content("Status: #{invoice1.status}")
    expect(page).to have_content("Invoice ##{invoice1.id}")
    expect(page).to have_content("Created on: #{invoice1.created_at.strftime('%A, %B %d, %Y')}")
    expect(page).to have_content("#{invoice1.customer.first_name} #{invoice1.customer.last_name}")
  end

  it 'lists items on the invoice' do
    visit "/admin/invoices/#{invoice1.id}"
    within '#itemtable' do
      expect(page).to have_content('Item Name')
      expect(page).to have_content('Unit Price')
      expect(page).to have_content('Status')
      expect(page).to have_content('Quantity')
    end

    within "#invoice-item-#{invoice_item1.id}" do
      expect(page).to have_text(item1.name.to_s)
      expect(page).to have_text('$30.11')
      expect(page).to have_text(invoice_item1.quantity.to_s)
      expect(page).to have_text(invoice_item1.status.to_s)
    end
  end

  it 'shows total revenue that will be generated from this invoice' do
    visit "/admin/invoices/#{invoice1.id}"

    expect(page).to have_content('Total Revenue: $55.35')
  end

  it 'has a select field to update invoice status' do
    visit "/admin/invoices/#{invoice1.id}"

    expect(invoice1.status).to eq('in progress')

    have_select :status,
                selected: 'in progress',
                options: ['in progress', 'completed', 'cancelled']

    select 'completed', from: :status
    click_button 'Update Invoice Status'

    expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
    invoice1.reload
    expect(invoice1.status).to eq('completed')

    have_select :status,
                selected: 'completed',
                options: ['in progress', 'completed', 'cancelled']
  end
end
