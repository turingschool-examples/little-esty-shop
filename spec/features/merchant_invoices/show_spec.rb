require 'rails_helper'

RSpec.describe 'show page' do
  before(:each) do
    @merchant = Merchant.first
    @inv_id = @merchant.invoice_ids.first
    @invoice = Invoice.find(@inv_id)
    visit "/merchants/#{@merchant.id}/invoices/#{@inv_id}"
  end

  it 'shows invoice id and status' do

    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
  end

  it 'shows created_at information as day of week, month day #, year' do

    expect(page).to have_content("Sunday, March 25, 2012")
  end

  it 'shows the first and last name of the customer related to the invoice' do
    customer = Customer.find(@invoice.customer_id)

    expect(page).to have_content(customer.first_name)
    expect(page).to have_content(customer.last_name)
  end

  it 'shows invoice total revenue' do
    customer = Customer.find(@invoice.)

    expect(page).to have_content(customer.first_name)

  end
end
