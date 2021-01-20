require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:each) do
      # Customers:
      @sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
      @joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
      @billy    = Customer.create!(first_name: 'Billy', last_name: 'Joel')
      @steve    = Customer.create!(first_name: 'Steve', last_name: 'Carrell')
      @frank    = Customer.create!(first_name: 'Frank', last_name: 'Sinatra')
      @Jon      = Customer.create!(first_name: 'Jon', last_name: 'Travolta')
      # Merchants:
      @amazon   = Merchant.create!(name: 'Amazon')
      @alibaba  = Merchant.create!(name: 'Alibaba')
      # Invoices:
      @invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @amazon.id)
      @invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: @alibaba.id)
      @invoice3 = Invoice.create!(status: 0, customer_id: @billy.id, merchant_id: @alibaba.id)
      @invoice4 = Invoice.create!(status: 0, customer_id: @steve.id, merchant_id: @amazon.id)
      @invoice5 = Invoice.create!(status: 0, customer_id: @frank.id, merchant_id: @alibaba.id)
      @invoice6 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: @alibaba.id)
      @invoice7 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @alibaba.id)
      # Transactions:
      @tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice2.id,)
      @tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 1, invoice_id: @invoice1.id,)
      @tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice3.id,)
      @tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice4.id,)
      @tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice5.id,)
      @tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice5.id,)
      @tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 1, invoice_id: @invoice6.id,)
      @tx8      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice7.id,)
      # Items:
      @candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: @amazon.id)
      @backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
      # InvoiceItems:
      @invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @candle.id)
      @invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @backpack.id)
    end

  describe 'validations' do
    it { should validate_presence_of :customer_id}
    it { should validate_presence_of :merchant_id}
  end

  describe 'relationships' do
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'model methods' do
    it 'Can find ids of invoices whose items are not shipped' do
      expect(Invoice.not_shipped.first.id).to eq(@invoice1.id)
    end
  end

  it 'Can calculate the total revenue that will be generated from this invoice' do
    expect(@invoice1.total_revenue).to eq(175.0)
  end

  it 'Can display the invoice creation date of its 5 most popular items' do
    date = Invoice.best_day.created_at
    expected = date.strftime("%A, %B %d, %Y")
    expect(expected).to eq("Wednesday, January 20, 2021")
  end


end
