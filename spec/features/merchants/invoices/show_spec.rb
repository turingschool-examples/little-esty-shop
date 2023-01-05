require 'rails_helper'

RSpec.describe 'Merchants Invoice Show' do
  it 'Shows all of the information for the specific invoice' do
    merchant = Merchant.find(1)
    invoice = merchant.invoices.first
    visit merchant_invoice_path(merchant, invoice)

    expect(page).to have_content(merchant.name)
    expect(page).to have_content(invoice.id)
    expect(page).to have_content(invoice.status)
    expect(page).to have_content(invoice.created_at.strftime('%A, %B %-d, %Y'))
    expect(page).to have_content(invoice.customer.first_name)
    expect(page).to have_content(invoice.customer.last_name)
  end
end