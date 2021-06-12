require 'rails_helper'

RSpec.describe 'invoice index page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @item1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @antimerchant.id)
    @item4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant.id)
    @item5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @antimerchant.id)
    @item6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @merchant.id)
    @invoice1 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice4 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice_item1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice1.id, item_id: @item2.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 4, unit_price: 19.4, status: 1, invoice_id: @invoice2.id, item_id: @item3.id)
    @invoice_item4 = InvoiceItem.create!(quantity: 1, unit_price: 12.2, status: 1, invoice_id: @invoice2.id, item_id: @item4.id)
    @invoice_item5 = InvoiceItem.create!(quantity: 2, unit_price: 10.4, status: 1, invoice_id: @invoice2.id, item_id: @item6.id)
    @invoice_item6 = InvoiceItem.create!(quantity: 7, unit_price: 15.3, status: 1, invoice_id: @invoice3.id, item_id: @item5.id)
    @invoice_item7 = InvoiceItem.create!(quantity: 6, unit_price: 10.4, status: 1, invoice_id: @invoice3.id, item_id: @item6.id)
    @invoice_item8 = InvoiceItem.create!(quantity: 3, unit_price: 19.4, status: 1, invoice_id: @invoice4.id, item_id: @item3.id)
    @invoice_item9 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice4.id, item_id: @item5.id)
  end

  it 'shows all of the invoices that include at least one of the merchants items and has a link on each invoice id to the invoice show page' do
    visit "/merchants/#{@merchant.id}/invoices"

    expect(page).to have_content("#{@invoice1.id}")
    expect(page).to have_content("#{@invoice2.id}")
    expect(page).to have_content("#{@invoice3.id}")

    expect(page).to have_link("#{@invoice1.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}")
    expect(page).to have_link("#{@invoice2.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice2.id}")
    expect(page).to have_link("#{@invoice3.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice3.id}")
    expect(page).to have_no_link("#{@invoice4.id}")
  end

  it 'does not show invoices that only have items that belong to other merchants' do
    visit "/merchants/#{@merchant.id}/invoices"

    expect(page).to have_no_content("#{@invoice4.id}")
  end

  it 'redirects the user to the invoice show page when they click the id of the invoice' do
    visit "/merchants/#{@merchant.id}/invoices"

    click_link("#{@invoice1.id}")

    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice1.id}")
  end
end
