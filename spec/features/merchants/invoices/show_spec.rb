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

  it 'Shows information for each individual item on the invoice' do
    merchant = Merchant.find(1)
    invoice = merchant.invoices.first
    visit merchant_invoice_path(merchant, invoice)

    invoice.items.each do |item|
      expect(page).to have_content(item.name).once
    end

    invoice.invoice_items.each do |invoice_item|
      expect(page).to have_content(invoice_item.quantity)
      expect(page).to have_content(invoice_item.unit_price_to_dollars)
      expect(page).to have_content(invoice_item.status)
    end

    not_invoice = Merchant.find(2).invoices.second

    not_invoice.items.each do |item|
      expect(page).to_not have_content(item.name)
    end
  end
end