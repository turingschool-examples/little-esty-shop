require 'rails_helper'

RSpec.describe 'the merchant invoice show page' do



  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 1)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 1)}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 1)}
  let!(:item_4) {merchant_1.items.create!(name: 'Green Pebble', description: 'Shiny rock', unit_price: 1)}

  let!(:customer_1) {Customer.create!(first_name: 'Billy', last_name: 'Carruthers')}

  let!(:invoice_1) {customer_1.invoices.create!(status: 'completed' )}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 10, unit_price: 1, status: 'shipped', created_at: Time.new(2021))}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 20, unit_price: 1, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 30, unit_price: 1, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_4.id, quantity: 5, unit_price: 1, status: 'pending', created_at: Time.new(2021))}

  let!(:discount_1) {Discount.create!(percent_off: 10, min_quantity: 10, merchant_id: merchant_1.id)}
  let!(:discount_2) {Discount.create!(percent_off: 20, min_quantity: 20, merchant_id: merchant_1.id)}
  let!(:discount_3) {Discount.create!(percent_off: 30, min_quantity: 30, merchant_id: merchant_1.id)}


  it 'displays invoice attributes' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d %Y"))
  end

  it 'displays customer attributes' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content(customer_1.first_name)
    expect(page).to have_content(customer_1.last_name)
  end

  it 'shows all item information on the invoice' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)
    expect(page).to have_content(invoice_item_1.quantity)
    expect(page).to have_content(invoice_item_2.quantity)
    expect(page).to have_content(invoice_item_3.quantity)
    expect(page).to have_content(invoice_item_1.unit_price)
    expect(page).to have_content(invoice_item_2.unit_price)
    expect(page).to have_content(invoice_item_3.unit_price)
    expect(page).to have_content(invoice_item_1.status)
    expect(page).to have_content(invoice_item_2.status)
    expect(page).to have_content(invoice_item_3.status)
  end


  it 'updates invoice item status when selected from a dropdown menu ' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"
    within "##{item_1.id}" do
      expect(page).to have_content('Status: shipped')
      select 'packaged', from: :new_invoice_item_status
      click_button("Update Item Status")
    end
    expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}")
    within "##{item_1.id}" do
      expect(page).to have_content('Status: packaged')
      expect(page).to_not have_content('Status: shipped')
    end
  end

  it 'displays total revenue for merchants invoices' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content('Total Revenue: 65')
  end

  it 'displays discounted total revenue for merchants invoices' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content('Total Discounted Revenue: 51')
  end

  it 'displays link to discount applied for items - routes to discount show page:' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to have_link("#{item_1.name} discount")
    click_link "#{item_1.name} discount"
    expect(current_path).to eq ("/merchants/#{merchant_1.id}/discounts/#{discount_1.id}")
  end

  it 'doesnt show discount link for items without a discount' do
    visit "/merchants/#{merchant_1.id}/invoices/#{invoice_1.id}"

    expect(page).to_not have_link("#{item_4.name} discount")
  end

end
