require 'rails_helper'

RSpec.describe 'Admin Invoice Show' do
  it 'Displays invoice ID, status, created_at, and customer first/last name' do
    visit admin_invoice_path(Invoice.first.id)

    expect(page).to have_content(Invoice.first.id)
    expect(page).to have_content(Invoice.first.created_at.strftime('%A, %B %-d, %Y'))
    expect(page).to have_content(Invoice.first.customer.first_name)
    expect(page).to have_content(Invoice.first.customer.first_name)
  end

  it 'Displays invoice items name, qty, price, and status' do
    visit admin_invoice_path(Invoice.first.id)

    within "#invoice_items_#{Invoice.first.items.first.id}" do
      expect(page).to have_content(Invoice.first.items.first.name)
      expect(page).to have_content(Invoice.first.invoice_items.first.quantity)
      expect(page).to have_content(Invoice.first.invoice_items.first.unit_price_to_dollars)
      expect(page).to have_content(Invoice.first.invoice_items.first.status.capitalize)
    end
  end

  it 'Displays the total revenue for the invoice' do
    visit admin_invoice_path(Invoice.first.id)

    expect(page).to have_content('Invoice Total: $21,067.77')
  end

  it 'Has a select field to update the invoice status' do
    invoice_1 = Invoice.first

    visit admin_invoice_path(invoice_1.id)

    expect(invoice_1.status).to eq('cancelled')

    within "#invoice_#{invoice_1.id}_status" do
      expect(page).to have_select('invoice[status]', selected: 'Cancelled')
      select('In Progress', from: 'invoice[status]')
      click_button 'Update Invoice Status'
    end
  end
end
