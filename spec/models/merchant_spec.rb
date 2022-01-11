require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items)}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:customers).through(:invoices)}
  end

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks', status: 'enabled')}
  let!(:merchant_2) {Merchant.create!(name: 'Dylans harps', status: 'enabled')}
  let!(:merchant_3) {Merchant.create!(name: 'Croixs Roids', status: 'enabled')}
  let!(:merchant_4) {Merchant.create!(name: 'Chris Ice Picks', status: 'disabled')}
  let!(:merchant_5) {Merchant.create!(name: 'Jacksons Merry Wreaths', status: 'disabled')}
  let!(:merchant_6) {Merchant.create!(name: 'Mikes Fresh Pike', status: 'disabled')}
  let!(:merchant_7) {Merchant.create!(name: 'Jamisons Special Code Concoction', status: 'enabled')}


  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50)}
  let!(:item_4) {merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50)}
  let!(:item_5) {merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50)}
  let!(:item_6) {merchant_1.items.create!(name: 'Healing Crystal', description: 'does nothing', unit_price: 50)}
  let!(:item_10) {merchant_1.items.create!(name: 'Delicious Gemfile', description: 'fixes everything', unit_price: 650)}


  let!(:item_7) {merchant_2.items.create!(name: 'Green Rock', description: 'A big green rock', unit_price: 50)}
  let!(:item_8) {merchant_2.items.create!(name: 'Colorado Sandstone', description: 'crumbly', unit_price: 50)}
  let!(:item_9) {merchant_2.items.create!(name: 'Salt Lick', description: 'delicious', unit_price: 50)}


  let!(:customer_1) {Customer.create!(first_name: 'Billy', last_name: 'Carruthers')}
  let!(:customer_2) {Customer.create!(first_name: 'Dave', last_name: 'King')}
  let!(:customer_3) {Customer.create!(first_name: 'Reid', last_name: 'Anderson')}
  let!(:customer_4) {Customer.create!(first_name: 'Elvind', last_name: 'Opsvik')}
  let!(:customer_5) {Customer.create!(first_name: 'Ethan', last_name: 'Iverson')}
  let!(:customer_6) {Customer.create!(first_name: 'Chris', last_name: 'Speed')}
  let!(:customer_7) {Customer.create!(first_name: 'John', last_name: 'Zorn')}


  let!(:invoice_1) {customer_1.invoices.create!(status: 'completed', created_at: Time.new(2021))}
  let!(:invoice_2) {customer_2.invoices.create!(status: 'completed' )}
  let!(:invoice_3) {customer_3.invoices.create!(status: 'completed' )}
  let!(:invoice_4) {customer_4.invoices.create!(status: 'completed' )}
  let!(:invoice_5) {customer_5.invoices.create!(status: 'completed' )}
  let!(:invoice_6) {customer_6.invoices.create!(status: 'completed' )}
  let!(:invoice_7) {customer_7.invoices.create!(status: 'completed')}



  #Billy
  let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_7) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_8) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  #Dave, Reid, Elvind
  let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  #Ethan
  let!(:transaction_5) {invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_9) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}
  let!(:transaction_10) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}
  let!(:transaction_11) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}

  #Chris
  let!(:transaction_6) {invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')}

  #john
  let!(:transaction_12) {invoice_7.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 3, unit_price: 100, status: 'shipped')}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'packaged')}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2020))}
  let!(:invoice_item_7) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 50, status: 'shipped', created_at: Time.new(2018))}

  let!(:invoice_item_5) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 100, status: 'pending', created_at: Time.new(2019))}
  let!(:invoice_item_6) {InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2018))}

   let!(:invoice_item_8) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_7.id, quantity: 1, unit_price: 50, status: 'shipped', created_at: Time.new(2018))}
   let!(:invoice_item_9) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_8.id, quantity: 1, unit_price: 100, status: 'pending', created_at: Time.new(2019))}
   let!(:invoice_item_10) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_9.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2018))}

   let!(:invoice_item_11) {InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_10.id, quantity: 1, unit_price: 650, status: 'pending', created_at: Time.new(2018))}




  describe 'instance methods' do

    it "favorite customers" do
      expect(merchant_1.favorite_customers).to eq([customer_5, customer_1, customer_2, customer_3,  customer_4])
    end

    it 'items_ready_to_ship' do
      expect(merchant_1.items_ready_to_ship).to eq([invoice_item_6, invoice_item_11, invoice_item_5, invoice_item_4, invoice_item_3, invoice_item_2])
    end

    it "total_revenue" do
      expect(merchant_2.total_revenue).to eq(200)
    end


  end

  describe 'class methods' do

    it 'only_enabled' do
      merchants = Merchant.all
      expect(merchants.only_enabled).to eq([merchant_1, merchant_2, merchant_3, merchant_7])
    end

    it 'only_disabled' do
      merchants = Merchant.all
      expect(merchants.only_disabled).to eq([merchant_4, merchant_5, merchant_6])
    end

    it 'top_5_total_revenue' do
      expect(Merchant.top_5_total_revenue).to eq([merchant_1, merchant_2])
      #beef out test
    end

    it "best_day" do
      expect(merchant_1.best_day).to eq("Friday, January 01 2021")
    end



  end
end
