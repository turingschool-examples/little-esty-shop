require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Roald')
    @merchant_2 = Merchant.create!(name: 'Big Rick')

    @customer_1 = Customer.create!(first_name: 'Not', last_name: 'Roald')
    @customer_2 = Customer.create!(first_name: 'Big', last_name: 'Rick')
    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @invoice_2 = @customer_2.invoices.create!(status: 1)
    @item_1 = @merchant_1.items.create!(name: 'Cactus Juice', description: 'Its the quechiest', unit_price: 100)
    @item_2 = @merchant_1.items.create!(name: 'Other Item', description: 'Not so quenchy', unit_price: 234)
    @item_3 = @merchant_1.items.create!(name: 'Not Listed', description: 'Undefined', unit_price: 0)
    @item_4 = @merchant_2.items.create!(name: 'Not Listed', description: 'Undefined', unit_price: 0)
    @invoice_items_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 1000, status: 0)
    @invoice_items_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 2340, status: 1)
    @invoice_items_2 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 2340, status: 1)

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end

  it 'shows the invoice show page' do
    expect(page).to have_content(@invoice_1.id)
  end

  it 'shows invoice status' do
    expect(page).to have_content(@invoice_1.status)
  end

  it 'shows the created at in date format' do
    expect(page).to have_content(Date.today.strftime('%A, %B %d, %Y'))
  end

  it 'shows the customer first and last name' do
    expect(page).to have_content('Not')
    expect(page).to have_content('Roald')
  end

  it 'shows all item names' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
  end

  it 'shows quantity ordered' do
    expect(page).to have_content(@invoice_items_1.quantity)
    expect(page).to have_content(@invoice_items_2.quantity)
  end

  it 'shows the unit price' do
    expect(page).to have_content(@invoice_items_1.unit_price)
    expect(page).to have_content(@invoice_items_2.unit_price)
  end

  it 'shows the status' do
    visit "/merchants/#{@merchant_2.id}/invoices/#{@invoice_2.id}"
    expect(page).to have_content('pending')
    page.select('shipped', from: :status)
    click_button('Update Status')
    expect(current_path).to eq("/merchants/#{@merchant_2.id}/invoices/#{@invoice_2.id}")
    expect(page).to have_content('shipped')
  end

  it 'shows total revenue' do
    expect(page).to have_content(3340)
  end
end
