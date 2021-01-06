require 'rails_helper'

RSpec.describe Customer, type: :model do
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
  end

  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end

  describe 'relationships' do
    it {should have_many :invoices}
    it {should have_many(:merchants).through(:invoices)}
  end

  describe 'instance methods' do
  end
end