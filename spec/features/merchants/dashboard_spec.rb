require 'rails_helper'

describe 'Merchant Dashboard' do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')

    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  it 'displays merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end

  it 'has a link to view all merchant items' do
    click_link "Merchant Items"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
  end

  it 'has a link to view all merchant invoices' do
    click_link "Merchant Invoices"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
  end

  it "lists items ready to ship from oldest to newest" do
    customer_1 = create(:customer)
    merchant_6 = Merchant.create!(name: 'Rob')
    item_6 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_6_name')
    item_7 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_7_name')
    item_8 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_8_name')
    item_9 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_9_name')
    invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-25 09:54:09 UTC")
    invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2013-03-25 09:54:09 UTC")
    invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2014-03-25 09:54:09 UTC")
    invoice_9 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2015-03-25 09:54:09 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 1, quantity: 1, unit_price: 5)
    invoice_item_7 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_7.id, status: 1, quantity: 10, unit_price: 5)
    invoice_item_8 = create(:invoice_item, item_id: item_8.id, invoice_id: invoice_8.id, status: 1, quantity: 10, unit_price: 5)
    invoice_item_9 = create(:invoice_item, item_id: item_9.id, invoice_id: invoice_9.id, status: 2, quantity: 10, unit_price: 5)

    visit "/merchants/#{merchant_6.id}/dashboard"

    within '#ready_to_ship' do
      expect(page).to have_content("Item: #{item_6.name} - Invoice Date: #{invoice_6.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Item: #{item_7.name} - Invoice Date: #{invoice_7.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Item: #{item_8.name} - Invoice Date: #{invoice_8.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to_not have_content("Item: #{item_9.name} - Invoice Date: #{invoice_9.created_at.strftime("%A, %B %d, %Y")}")

      expect(item_6.name).to appear_before(item_7.name)
      expect(item_7.name).to appear_before(item_8.name)
    end
  end
end
