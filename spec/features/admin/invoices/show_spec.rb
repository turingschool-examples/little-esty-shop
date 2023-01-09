require 'rails_helper'

RSpec.describe 'Admin Invoice Show' do
  it 'Displays invoice ID, status, created_at, and customer first/last name' do
    visit admin_invoice_path(Invoice.first.id)

    expect(page).to have_content(Invoice.first.id)
    expect(page).to have_content(Invoice.first.status)
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
      expect(page).to have_content(Invoice.first.invoice_items.first.status)
    end
  end

  it 'Displays the total revenue for the invoice' do
    visit admin_invoice_path(Invoice.first.id)

    expect(page).to have_content('Invoice Total: $21,067.77')
  end
end