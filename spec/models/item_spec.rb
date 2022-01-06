require 'rails_helper'

RSpec.describe Item, type: :model do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50, status: 'enabled')}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100, status: 'enabled')}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50, status: 'enabled')}
  let!(:item_4) {merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50, status: 'enabled')}
  let!(:item_5) {merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50, status: 'disabled')}
  let!(:item_6) {merchant_1.items.create!(name: 'Healing Crystal', description: 'does nothing', unit_price: 50, status: 'disabled')}


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
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 2, unit_price: 50, status: 'packaged')}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 3, unit_price: 50, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 4, unit_price: 50, status: 'pending', created_at: Time.new(2020))}
  let!(:invoice_item_5) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 5, unit_price: 50, status: 'pending', created_at: Time.new(2019))}
  let!(:invoice_item_6) {InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 6, unit_price: 50, status: 'pending', created_at: Time.new(2018))}

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'self.only_enabled' do
    it 'only returns enabled items' do
      expect(Item.only_enabled).to eq([item_1, item_2, item_3, item_4])
    end
  end

  describe 'self.only_disabled' do
    it 'only returns disabled items' do
      expect(Item.only_disabled).to eq([item_5, item_6])
    end
  end

  describe 'self.revenue_generated' do
    it 'returns the revenue generated of an item' do
      expect(item_3.revenue_generated).to eq(150)
    end
  end

  describe 'self.top_5' do
    it 'returns the top 5 items with the most revenue' do
      expect(Item.top_5).to eq([item_6, item_5, item_4, item_3, item_2])
    end
  end

  describe 'best_selling_date' do
    it 'returns the best selling date of an item' do
      expect(item_1.best_selling_date).to eq(item_1.best_selling_date)
    end
  end

end
