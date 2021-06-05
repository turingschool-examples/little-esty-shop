require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_many(:merchants).through(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
  end

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
  #
  describe 'instance methods' do
    describe '#item_name' do
      it 'can grab the item name associated with the item_id' do
        expect(@invoice_item_1.item_name).to eq('Thing 1')
        expect(@invoice_item_2.item_name).to eq('Thing 2')
      end 
    end
  end
end
