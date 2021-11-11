require 'rails_helper'

# FactoryBot.find_definitions

RSpec.describe 'show page' do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)

    @invoice = create(:invoice, customer: @customer)
    @item = create(:item, merchant: @merchant)
    @inv_item = create(:invoice_item, invoice: @invoice, item: @item)


    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  it 'shows invoice id and status' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
  end

  it 'shows created_at information as day of week, month day #, year' do
    expect(page).to have_content(DateTime.now.new_offset(0).strftime("%A, %B %d, %Y"))
  end

  it 'shows the first and last name of the customer related to the invoice' do
    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  it 'shows the item name, quantity ordered, price, invoice item status' do
    expect(page).to have_content(@invoice.items.first.name)
    expect(page).to have_content(@invoice.items.first.invoice_item_quantity(@invoice))
    expect(page).to have_content("$")
    expect(page).to have_content(@invoice.items.first.invoice_item_status(@invoice))
  end

  it 'shows invoice total revenue' do
    expect(page).to have_content("$")
  end

  it 'shows dropdown for changing status' do
    expect(page).to have_content('packaged pending shipped')
    expect(page).to have_content('Change status')
    within("#item-#{@invoice.items.last.id}") do
      expect(page).to_not have_content("Status: #{@invoice.status}")
      select('shipped', from: 'invoice_item_status')
      expect(page).to have_select('invoice_item_status', selected: 'shipped')
      expect(page).to have_content('shipped')
    end
  end
end
