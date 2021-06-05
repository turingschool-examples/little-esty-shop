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
  
  before :each do
    @customer1 = Customer.create!(first_name: "Bobby", last_name: "Mendez")
    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id)
    @merchant1 = Merchant.create!(name: "Nike")
    @item1 = Item.create!(name: "Kobe zoom 5's", description: "Best shoe in basketball hands down!", unit_price: 12500, merchant_id: @merchant1.id)
    @invoice_item1 = InvoiceItem.create!(quantity: 2, unit_price: 25000, status: 0, invoice_id: @invoice1.id, item_id: @item1.id)
  end
  
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  
  describe 'instance methods' do
    describe '#total_revenue' do
      it 'total revenue for an invoice' do
        
        expect(@invoice1.total_revenue).to eq(50000)
      end
    end
  end
end
