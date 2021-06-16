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

  describe 'enum' do
    it { should define_enum_for(:status) }
  end

  before :each do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @customer = Customer.create!(first_name: 'John', last_name: 'Smith')
    @item1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 10, merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 20, merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 25, merchant_id: @merchant.id)
    @invoice1 = Invoice.create!(status: 1, customer_id: @customer.id, created_at: "2021-06-05 20:11:38.553871" )
    @invoice_item1 = InvoiceItem.create!(quantity: 12, unit_price: 10, status: 1, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 25, unit_price: 20, status: 1, invoice_id: @invoice1.id, item_id: @item2.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 6, unit_price: 25, status: 1, invoice_id: @invoice1.id, item_id: @item3.id)
    @bulk_discount_1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 10, merchant_id: @merchant.id)
    @bulk_discount_2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 25, merchant_id: @merchant.id)
  end

  describe 'instance methods' do
    describe '#item_name' do
      it 'can grab the item name associated with the item_id' do
        expect(@invoice_item1.item_name).to eq('Thing 1')
        expect(@invoice_item2.item_name).to eq('Thing 2')
        expect(@invoice_item3.item_name).to eq('Thing 3')
      end
    end
    describe '#total_rev' do
      it 'can find the highest discount available for the invoice item' do
        expect(@invoice_item1.highest_discount_percent).to eq(0.10)
        expect(@invoice_item2.highest_discount_percent).to eq(0.20)
        expect(@invoice_item3.highest_discount_percent).to eq(0)
      end

      it 'can find the total revenue of the invoice item applying the best discount when possible' do
        expect(@invoice_item1.total_rev).to eq(108)
        expect(@invoice_item2.total_rev).to eq(400)
        expect(@invoice_item3.total_rev).to eq(150)
      end

      it 'can return true or false if the invoice_item has a discount attached' do
        expect(@invoice_item1.discount?).to eq(true)
        expect(@invoice_item2.discount?).to eq(true)
        expect(@invoice_item3.discount?).to eq(false)
      end
    end
  end
end
