require 'rails_helper'
RSpec.describe 'the merchants dashboard page' do

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
  let!(:invoice_6) {customer_6.invoices.create!(status: 'completed' )}

  #Billy
  let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_7) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_8) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  #Dave, Reid, Elvind
  let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_2_) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  #Ethan
  let!(:transaction_5) {invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_9) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}
  let!(:transaction_10) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}
  let!(:transaction_11) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}

  #Chris
  let!(:transaction_6) {invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 100, status: 'shipped')}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'packaged')}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2020))}
  let!(:invoice_item_7) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 50, status: 'shipped', created_at: Time.new(2018))}

  let!(:invoice_item_5) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 100, status: 'pending', created_at: Time.new(2019))}
  let!(:invoice_item_6) {InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2018))}


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

  it "shows the names of top 5 customers" do
    visit "/merchants/#{merchant_1.id}/dashboard"

    within("#top5") do
      expect("Name: #{customer_5.first_name}, Succesful Transactions: #{customer_5.transactions.length}")
      .to appear_before("Name: #{customer_1.first_name}, Succesful Transactions: #{customer_1.transactions.length}")

      expect("Name: #{customer_1.first_name}, Succesful Transactions: #{customer_1.transactions.length}")
      .to appear_before("Name: #{customer_2.first_name}, Succesful Transactions: #{customer_2.transactions.length}")

      expect("Name: #{customer_2.first_name}, Succesful Transactions: #{customer_2.transactions.length}")
      .to appear_before("Name: #{customer_3.first_name}, Succesful Transactions: #{customer_3.transactions.length}")

      expect("Name: #{customer_3.first_name}, Succesful Transactions: #{customer_3.transactions.length}")
      .to appear_before("Name: #{customer_4.first_name}, Succesful Transactions: #{customer_4.transactions.length}")
    end
  end

  it 'displays items not yet shipped' do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)
    expect(page).to_not have_content(item_1.name)
  end

  it "displays the date of items not yet shipped by most recent created first" do
    visit "/merchants/#{merchant_1.id}/dashboard"

    expect(item_6.name).to appear_before(item_5.name)
    expect(item_5.name).to appear_before(item_4.name)
    expect(item_4.name).to appear_before(item_3.name)
    expect(item_3.name).to appear_before(item_2.name)

  end


end
