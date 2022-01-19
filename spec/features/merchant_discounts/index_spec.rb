require 'rails_helper'
# require 'webmock'
# require 'httparty'
RSpec.describe 'the merchant discount index page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:discount_1) {Discount.create!(percent_off: 20, min_quantity: 10, merchant_id: merchant_1.id)}

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

  before(:each) do
    visit "/merchants/#{merchant_1.id}/discounts"
  end

  it 'has information for all discounts' do
    within "#discounts" do
      expect(page).to have_content("Discount percent off: 20")
      expect(page).to have_content("Discount minimum quantity: 10")
    end
  end

  it 'has link to show page for one discount' do
    within "#discounts" do
      expect(page).to have_link("See discount details")
      click_link("See discount details")
      expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/#{discount_1.id}")
    end
  end

  it 'has link to create a new discount' do
    expect(page).to have_link("Create a new discount")
    click_link ("Create a new discount")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts/new")
  end

  it 'has link to delete discount' do
    within "#discounts" do
      visit "/merchants/#{merchant_1.id}/discounts"
      expect(page).to have_button("Delete discount - id #{discount_1.id}")
      click_button "Delete discount - id #{discount_1.id}"
      expect(current_path).to eq("/merchants/#{merchant_1.id}/discounts")
      expect(page).to_not have_button("Delete discount - id #{discount_1.id}")
    end
  end


end
