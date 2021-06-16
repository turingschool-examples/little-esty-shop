require 'rails_helper'

RSpec.describe 'invoice show page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @bulk_discount1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 40, merchant_id: @merchant.id)
    @bulk_discount2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 75, merchant_id: @merchant.id)
    @item1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @antimerchant.id)
    @invoice1 = Invoice.create!(status: 1, customer_id: @customer.id)
    @invoice_item1 = InvoiceItem.create!(quantity: 20, unit_price: 14.9, status: 1, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 50, unit_price: 16.3, status: 1, invoice_id: @invoice1.id, item_id: @item2.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 80, unit_price: 19.4, status: 1, invoice_id: @invoice1.id, item_id: @item3.id)
    @transaction1 = Transaction.create!(credit_card_number: 1234432198766789, result: 1, invoice_id: @invoice1.id)

  end

  it 'displays the invoice id, status, created at, and customer name' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("#{@invoice1.id}")
    expect(page).to have_content("#{@invoice1.status_for_view}")
    expect(page).to have_content("#{@invoice1.convert_create_date}")
    expect(page).to have_content("#{@customer.first_name}")
    expect(page).to have_content("#{@customer.last_name}")
  end

  it 'shows all items on the invoice with their names, quantities, unit prices, and status of the invoice item' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("Items:")
    expect(page).to have_content("#{@item1.name}")
    expect(page).to have_content("#{@invoice_item1.quantity}")
    expect(page).to have_content("#{@invoice_item1.unit_price}")
    expect(page).to have_content("#{@invoice_item1.status_for_view}")

    expect(page).to have_content("#{@item2.name}")
    expect(page).to have_content("#{@invoice_item2.quantity}")
    expect(page).to have_content("#{@invoice_item2.unit_price}")
    expect(page).to have_content("#{@invoice_item2.status_for_view}")

    expect(page).to have_no_content("#{@item3.name}")
  end

  it 'can show the total revenue generated by all of the items on the invoice that belong to this merchant' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("Total Non-Discounted Revenue from this Invoice:")
    expect(page).to have_content(@invoice1.merchant_total_revenue(@merchant.id))
  end

  it 'can show the total discounted revenue generated by all of the items on the invoice that belong to this merchant' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}"

    expect(page).to have_content("Total Discounted Revenue from this Invoice:")
    expect(page).to have_content(@invoice1.merchant_discounted_revenue(@merchant.id))
  end

  it 'can select a new status for the invoice item, submit the change, and show the new status when submitted' do
    visit "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}"

    within("##{@invoice_item1.id}") do
      page.select('Shipped', from: 'status')
      click_button('Update Item Status')
    end

    expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice1.id}")
    within("##{@invoice_item1.id}") do
      expect(page).to have_content('Shipped')
    end
  end

  it 'has the bulk discount show page link next to each invoice item if applicable' do
    within("##{@invoice_item2.id}") do
      expect(page).to have_link("Bulk Discount Used", href: "merchants/#{@merchant.id}/bulk_discounts/#{@invoice_item2.highest_discount.id)}")
    end

    within("##{@invoice_item1.id}") do
      expect(page).to have_no_link("Bulk Discount Used")
    end
  end
end
