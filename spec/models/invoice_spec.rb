require 'rails_helper'

RSpec.describe Invoice, type: :model do
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
  end

  describe 'validations' do
    it { should validate_presence_of :status}
    it { should validate_presence_of :customer_id}
    it { should validate_presence_of :merchant_id}
  end

  describe 'relationships' do
    it {should have_many :transactions}
  end

  describe 'instance methods' do
  end
end