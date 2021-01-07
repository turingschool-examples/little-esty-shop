require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    # Customers:
    @sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
    @joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
    @john     = Customer.create!(first_name: 'John', last_name: 'Hansen')
    @travolta = Customer.create!(first_name: 'Travolta', last_name: 'Hansen')
    @sal      = Customer.create!(first_name: 'Sal', last_name: 'Hansen')
    @tim      = Customer.create!(first_name: 'Tim', last_name: 'Hansen')
    @amazon   = Merchant.create!(name: 'Amazon')
    @alibaba  = Merchant.create!(name: 'Alibaba')
    @invoice1 = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @amazon.id)
    @invoice2 = Invoice.create!(status: 1, customer_id: @sally.id, merchant_id: @amazon.id)
    @invoice3 = Invoice.create!(status: 1, customer_id: @joel.id, merchant_id: @amazon.id)
    @invoice4 = Invoice.create!(status: 1, customer_id: @joel.id, merchant_id: @amazon.id)
    @invoice5 = Invoice.create!(status: 1, customer_id: @john.id, merchant_id: @amazon.id)
    @invoice6 = Invoice.create!(status: 1, customer_id: @john.id, merchant_id: @amazon.id)
    @invoice7 = Invoice.create!(status: 1, customer_id: @travolta.id, merchant_id: @amazon.id)
    @invoice8 = Invoice.create!(status: 1, customer_id: @travolta.id, merchant_id: @amazon.id)
    @invoice9 = Invoice.create!(status: 1, customer_id: @sal.id, merchant_id: @amazon.id)
    @invoice10 = Invoice.create!(status: 1, customer_id: @sal.id, merchant_id: @amazon.id)
    @invoice11 = Invoice.create!(status: 1, customer_id: @tim.id, merchant_id: @amazon.id)
    @invoice13 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @amazon.id)
    @tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, invoice_id: @invoice2.id,)
    @tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, invoice_id: @invoice1.id,)
    @tx3      = Transaction.create!(credit_card_number: 010001005551, credit_card_expiration_date: 20220101, invoice_id: @invoice3.id,)
    @tx4      = Transaction.create!(credit_card_number: 010001005552, credit_card_expiration_date: 20220101, invoice_id: @invoice4.id,)
    @tx5      = Transaction.create!(credit_card_number: 010001005553, credit_card_expiration_date: 20220101, invoice_id: @invoice5.id,)
    @tx6      = Transaction.create!(credit_card_number: 010001005554, credit_card_expiration_date: 20220101, invoice_id: @invoice6.id,)
    @tx7      = Transaction.create!(credit_card_number: 010001005550, credit_card_expiration_date: 20220101, invoice_id: @invoice7.id,)
    @tx8      = Transaction.create!(credit_card_number: 010001005556, credit_card_expiration_date: 20220101, invoice_id: @invoice8.id,)
    @tx9      = Transaction.create!(credit_card_number: 010001005557, credit_card_expiration_date: 20220101, invoice_id: @invoice9.id,)
    @tx10     = Transaction.create!(credit_card_number: 010001005523, credit_card_expiration_date: 20220101, invoice_id: @invoice10.id,)
    @tx11     = Transaction.create!(credit_card_number: 0100010055, credit_card_expiration_date: 20220101, invoice_id: @invoice11.id,)
    @candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: @amazon.id)
    @backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
    @invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @candle.id)
    @invitm2  = InvoiceItem.create!(status: 0, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @backpack.id)
  end

  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  # describe 'instance methods' do
  #   it "a merchant can identify its top 5 customer names" do
  #     expect(@amazon.top_five_customers).to eq([@sally.name, @joel.name, @john.name, @travolta.name, @sal.name])
  #   end
  # end
end
