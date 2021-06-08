require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:) }
  # end
  #
  before :each do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer.id, created_at: "2021-06-05 20:11:38.553871" )
    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id)
  end

  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end

  describe 'instance methods' do
    describe '#convert_create_date' do
      it 'making a date in readable fashion' do
        expect(@invoice_1.convert_create_date).to eq("Saturday, June 05, 2021")
      end
    describe '#merchant_total_revenue'
    it 'can give the total revenue for a merchants items on specific invoice' do
      expect(@invoice_1.merchant_total_revenue(@merchant.id)).to eq(111.3)
    end
    end
  end
end
