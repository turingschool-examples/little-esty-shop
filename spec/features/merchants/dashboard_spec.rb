require 'rails_helper'
RSpec.describe 'the merchants dashboard page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'GClassic rock', unit_price: 50)}


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
  let!(:invoice_6) {customer_6.invoices.create!(status: 'completed' )}

  let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_5) {invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_6) {invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')}

  let!(:transaction_7) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_8) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 50, status: 'shipped')}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'pending')}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2021))}


  it "shows the name of the merchant" do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_content(merchant_1.name)
  end

  it "links to merchant items index" do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_link('My Items')
    click_link 'My Items'
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
  end

  it "links to the merchant invoices index" do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_link('My Invoices')
    # click_link 'My Invoices'
    # expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
    # need to build this later, for merchant invoices index
  end

  xit "shows the names of top 5 customers" do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_content(customer_1.name)
    expect(page).to have_content(customer_2.name)
    expect(page).to have_content(customer_3.name)
    expect(page).to have_content(customer_4.name)
    expect(page).to have_content(customer_5.name)
  end

  it 'displays items not yet shipped' do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)
    expect(page).to_not have_content(item_1.name)
  end

  xit "displays the date of items not yet shipped by most recent created first" do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_content("Wednesday, January 05 2022")
    expect(item_2.name).to appear_before(item_3.name)
  end


end
