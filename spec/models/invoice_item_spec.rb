require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  before(:each) do
    # Customers:
    @sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
    @joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
    # Merchants:
    @amazon   = Merchant.create!(name: 'Amazon')
    @alibaba  = Merchant.create!(name: 'Alibaba')
    # Invoices:
    @invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @amazon.id,)
    @invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: @alibaba.id,)
    # Transactions:
    @tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, invoice_id: @invoice2.id,)
    @tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, invoice_id: @invoice1.id,)
    # Items:
    @candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: @amazon.id)
    @backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
    # InvoiceItems:
    @invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @candle.id)
    @invitm2  = InvoiceItem.create!(status: 0, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @backpack.id)
  end

  describe 'validations' do
    it { should validate_presence_of :item_id}
    it { should validate_presence_of :invoice_id}
    it { should validate_presence_of :unit_price}
    it { should validate_presence_of :quantity}
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'instance methods' do
  end
end
