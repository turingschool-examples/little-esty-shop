require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  before :each do
    @frank = Customer.create!(first_name: 'Frank', last_name: 'Enstein')

    @invoice_1 = @frank.invoices.create!(status: 2)
    @invoice_2 = @frank.invoices.create!(status: 2)
    @invoice_3 = @frank.invoices.create!(status: 2)

    @merchant_1 = Merchant.create!(name: 'LittleHomeSlice')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant_1.id, status: 1)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant_1.id, status: 1)
    @item_3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant_1.id, status: 1)

    @merchant_2 = Merchant.create!(name: 'BreadNButter')
    @item_4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant_2.id, status: 0)
    @item_5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant_2.id, status: 0)
    @item_6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @merchant_2.id, status: 0)
    @item_7 = Item.create!(name: 'Thing 7', description: 'This is the seventh thing.', unit_price: 116, merchant_id: @merchant_2.id, status: 0)
    @item_8 = Item.create!(name: 'Thing 8', description: 'This is the eighth thing.', unit_price: 18.2, merchant_id: @merchant_2.id, status: 0)
    @item_9 = Item.create!(name: 'Thing 9', description: 'This is the ninth thing.', unit_price: 17.7, merchant_id: @merchant_2.id, status: 0)
    @item_10 = Item.create!(name: 'Thing 10', description: 'This is the tenth thing.', unit_price: 21.9, merchant_id: @merchant_2.id, status: 0)
    @invoice_item_1 = @item_4.invoice_items.create!(quantity: 4, unit_price: 12.2, status: 2, invoice_id: @invoice_1.id)
    @invoice_item_2 = @item_5.invoice_items.create!(quantity: 3, unit_price: 15.3, status: 2, invoice_id: @invoice_1.id)
    @invoice_item_3 = @item_6.invoice_items.create!(quantity: 7, unit_price: 10.4, status: 2, invoice_id: @invoice_2.id)
    @invoice_item_4 = @item_7.invoice_items.create!(quantity: 4, unit_price: 11.6, status: 2, invoice_id: @invoice_2.id)
    @invoice_item_5 = @item_8.invoice_items.create!(quantity: 1, unit_price: 18.2, status: 2, invoice_id: @invoice_3.id)
    @invoice_item_6 = @item_9.invoice_items.create!(quantity: 5, unit_price: 17.7, status: 2, invoice_id: @invoice_3.id)
    @invoice_item_7 = @item_10.invoice_items.create!(quantity: 2, unit_price: 21.9, status: 2, invoice_id: @invoice_3.id)
  end

  describe 'class methods' do
    describe '.enable/disable items' do
      it 'can group enabled items' do
        expect(Item.enable_items).to eq([@item_1, @item_2, @item_3])
      end

      it 'can group disabled items' do
        expect(Item.disable_items).to eq([@item_4, @item_5, @item_6, @item_7, @item_8, @item_9, @item_10])
      end
    end
  end
#
#   describe 'instance methods' do
#     describe '#' do
#     end
#   end
end
