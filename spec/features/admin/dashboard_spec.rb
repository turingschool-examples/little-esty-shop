require 'rails_helper'

RSpec.describe 'Admin dashboard page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}


  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50)}
  let!(:item_4) {merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50)}
  let!(:item_5) {merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50)}
  let!(:item_6) {merchant_1.items.create!(name: 'Healing Crystal', description: 'does nothing', unit_price: 50)}


  let!(:customer_1) {Customer.create!(first_name: 'Billy', last_name: 'Carruthers')}
  let!(:customer_2) {Customer.create!(first_name: 'Dave', last_name: 'King')}
  let!(:customer_3) {Customer.create!(first_name: 'Reid', last_name: 'Anderson')}
  let!(:customer_4) {Customer.create!(first_name: 'Elvind', last_name: 'Opsvik')}
  let!(:customer_5) {Customer.create!(first_name: 'Ethan', last_name: 'Iverson')}
  let!(:customer_6) {Customer.create!(first_name: 'Chris', last_name: 'Speed')}

  let!(:invoice_1) {customer_1.invoices.create!(status: 'completed' )}
  let!(:invoice_2) {customer_2.invoices.create!(status: 'completed' )}
  let!(:invoice_3) {customer_3.invoices.create!(status: 'completed' )}
  let!(:invoice_4) {customer_4.invoices.create!(status: 'completed' )}
  let!(:invoice_5) {customer_5.invoices.create!(status: 'completed' )}
  let!(:invoice_6) {customer_6.invoices.create!(status: 'cancelled' )}
  let!(:invoice_7) {customer_1.invoices.create!(status: 'in progress' )}
  let!(:invoice_8) {customer_1.invoices.create!(status: 'in progress' )}




  let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_5) {invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_6) {invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')}
  let!(:transaction_7) {invoice_7.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 50, status: 'shipped')}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'packaged')}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2020))}
  let!(:invoice_item_5) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2019))}
  let!(:invoice_item_6) {InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2018))}
  let!(:invoice_item_7) {InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_1.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2017))}
  let!(:invoice_item_8) {InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'shipped', created_at: Time.new(2018))}


  it 'shows a header indicating that you are on the admin dashboard' do
    visit '/admin'
    expect(page).to have_content('Admin dashboard')
  end

  it "has links to the admin merchants index and the admin invoices index " do
    visit '/admin'
    expect(page).to have_link("Merchants Link")
    expect(page).to have_link("Invoices Link")
  end

  it "incomplete invoices" do
    visit '/admin'
    expect(page).to have_content("Incomplete Invoices:")
    expect("#{invoice_7.id}").to appear_before("#{invoice_6.id}")
    expect(page).to have_link(invoice_6.id)
    expect(page).to have_link(invoice_7.id)
  end


end

# Then I see a section for "Incomplete Invoices"
# In that section I see a list of the ids of all invoices
# That have items that have not yet been shipped
# And each invoice id links to that invoice's admin show page