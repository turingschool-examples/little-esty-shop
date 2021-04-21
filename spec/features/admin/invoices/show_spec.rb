require 'rails_helper'

RSpec.describe 'when I visit the admin invoices show page' do
  before(:each) do
    @merchant_1 = create(:merchant, name: "M1")
    @item_1 = create(:item, merchant: @merchant_1)
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, status: 'in progress')
    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: "packaged", quantity: 1, unit_price: 30)
    @customer_1.invoices << [@invoice_1]

  end

 it 'can see invoice id, status, created_at date, customer first and last name' do
  visit "/admin/invoices/#{@invoice_1.id}"
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end

  it 'allows user to select and change the invoices current status' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content('in progress')
    select('completed', from: 'status')
    click_button('Update Invoice Status')
    expect(page). to have_content('completed')
  end

  it 'shows total revenue for invoice' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page). to have_content("Total Revenue: #{@invoice_1.total_revenue}")
  end

  it 'shows the invoice item information' do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content(@invoice_item_1.item.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_1.status)
  end
end
