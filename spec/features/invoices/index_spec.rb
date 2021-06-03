require 'rails_helper'

RSpec.describe 'invoice index page' do
  before(:each) do
    # Customer.destroy_all
    # Merchant.destroy_all
    # Item.destroy_all
    # Invoice.destroy_all
    # InvoiceItem.destroy_all
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @antimerchant.id)
    @item_4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant.id)
    @item_5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @antimerchant.id)
    @item_6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @merchant.id)
    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 4, unit_price: 19.4, status: 1, invoice_id: @invoice_2.id, item_id: @item_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 1, unit_price: 12.2, status: 1, invoice_id: @invoice_2.id, item_id: @item_4.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 10.4, status: 1, invoice_id: @invoice_2.id, item_id: @item_6.id)
    @invoice_item_6 = InvoiceItem.create!(quantity: 7, unit_price: 15.3, status: 1, invoice_id: @invoice_3.id, item_id: @item_5.id)
    @invoice_item_7 = InvoiceItem.create!(quantity: 6, unit_price: 10.4, status: 1, invoice_id: @invoice_3.id, item_id: @item_6.id)
    @invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 19.4, status: 1, invoice_id: @invoice_4.id, item_id: @item_3.id)
    @invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice_4.id, item_id: @item_5.id)
  end

  it 'shows all of the invoices that include at least one of the merchants items' do
    visit "/merchants/#{@merchant.id}/invoices"

    expect(page).to have_content("#{@invoice_1}")
    expect(page).to have_content("#{@invoice_2}")
    expect(page).to have_content("#{@invoice_3}")
    expect(page).to have_no_content("#{@invoice_4}")
  end

  it 'has a link on each invoice id to the invoice show page' do
    visit "/merchants/#{@merchant.id}/invoices"

    expect(page).to have_link("#{@invoice_1.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_2.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_2.id}")
    expect(page).to have_link("#{@invoice_3.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}")
    expect(page).to have_no_link("#{@invoice_4.id}")
  end
end
