require 'rails_helper'

RSpec.describe Item, type: :model do

  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')

    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
    @customer3 = Customer.create!(first_name: 'Louis', last_name: 'Lane')
    @customer6 = Customer.create!(first_name: 'Matt', last_name: 'Murdock')

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)

    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: '2009-05-01 01:31:45')
    @invoice3 = Invoice.create!(status: 'completed', customer_id: @customer3.id, created_at: '2009-07-03 01:22:45')
    @invoice6 = Invoice.create!(status: 'completed', customer_id: @customer6.id, created_at: '2009-10-06 01:59:45')

    InvoiceItem.create!(quantity: 5, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 6, unit_price: 100, status: 'pending', item_id: @item1.id, invoice_id: @invoice3.id)
    InvoiceItem.create!(quantity: 20, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice6.id)

  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
    it { should validate_presence_of :merchant_id }
  end

  describe "Instance Methods" do
    describe "#top_item_selling_date" do
      it "returns the day an item sold the most quantity" do
        expect(@item1.top_item_selling_date).to eq('2009-10-06 01:59:45')
      end
    end
  end
end
