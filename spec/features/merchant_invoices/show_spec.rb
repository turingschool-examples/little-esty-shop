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

  it 'shows the item name, quantity ordered, price, invoice item status' do
    expect(page).to have_content(@invoice.items.first.name)
    expect(page).to have_content(@invoice.items.first.invoice_item_quantity(@invoice))
    expect(page).to have_content("$751.07")
    expect(page).to have_content(@invoice.items.first.invoice_item_status(@invoice))
  end

  it 'shows invoice total revenue' do
    expect(page).to have_content("$12,817.94")
  end

  it 'shows dropdown for changing status' do
    expect(page).to have_content('packaged pending shipped')
    expect(page).to have_content('Change status')
    save_and_open_page
    within("#item-#{@invoice.items.last.id}") do
      select('shipped', from: 'invoice_item_status')
    end
  end
end
