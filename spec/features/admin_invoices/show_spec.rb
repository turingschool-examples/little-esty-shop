require 'rails_helper'

RSpec.describe 'the admin invoice show page' do


  let!(:customer_6) {Customer.create!(first_name: 'Chris', last_name: 'Speed')}

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

  it 'links from the admin invoices index page' do
    visit 'admin/invoices'
    click_link "#{invoice_1.id}"
    expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
  end

  it 'displays invoice attributes' do
    visit "admin/invoices/#{invoice_1.id}"

    expect(page).to have_content("Invoice #{invoice_1.id}")
    expect(page).to have_content(invoice_1.customer_id)
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d %Y"))
    expect(page).to have_content(customer_1.first_name)
    expect(page).to have_content(customer_1.last_name)
  end

  it 'displays Item/InvoiceItem attributes' do
    # invoice_item_7 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'shipped')
    # invoice_item_8 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 2, unit_price: 150, status: 'packaged')
    # invoice_item_9 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_4.id, quantity: 3, unit_price: 200, status: 'pending')

    visit "admin/invoices/#{invoice_1.id}"

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)
    expect(page).to have_content(item_4.name)

    expect(page).to have_content(invoice_item_1.quantity)
    expect(page).to have_content(invoice_item_2.quantity)
    expect(page).to have_content(invoice_item_3.quantity)
    expect(page).to have_content(invoice_item_4.quantity)

    expect(page).to have_content(invoice_item_1.unit_price)
    expect(page).to have_content(invoice_item_2.unit_price)
    expect(page).to have_content(invoice_item_3.unit_price)
    expect(page).to have_content(invoice_item_4.unit_price)

    expect(page).to have_content(invoice_item_1.status)
    expect(page).to have_content(invoice_item_2.status)
    expect(page).to have_content(invoice_item_3.status)
    expect(page).to have_content(invoice_item_4.status)
  end

  it 'displays total revenue for this invoice' do

    visit "admin/invoices/#{invoice_1.id}"
    expect(page).to have_content('Total Revenue: 65') ### or 1050?
  end

  it 'displays discounted total revenue for merchants invoices' do
    visit "admin/invoices/#{invoice_1.id}"

    expect(page).to have_content('Total Discounted Revenue: 51')
  end



  it 'provides select field to edit the invoice status' do
    invoice_10 = customer_6.invoices.create!(status: 'in progress')

    visit "admin/invoices/#{invoice_10.id}"

    within "#status-select" do
      expect(page).to have_field(:status, with: 'in progress')
      expect(page).to have_button("Update Invoice Status")
      select 'completed', from: :status
      click_on 'Update Invoice Status'
    end

    expect(current_path).to eq("/admin/invoices/#{invoice_10.id}")
    expect(invoice_10.status).to eq('in progress')
  end

end
