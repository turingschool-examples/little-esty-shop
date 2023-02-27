require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end
  
  describe '::Class Methods' do
    before(:each) do
      @merchant = create(:merchant)

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant, status: "Enabled")
      @item_3 = create(:item, merchant: @merchant, status: "Enabled")
      @item_4 = create(:item, merchant: @merchant, status: "Enabled")
    end

    describe '::enabled' do
      it 'returns all items where the status is enabled' do
        expect(@merchant.items.enabled).to eq([@item_2, @item_3, @item_4])
        expect(@merchant.items.enabled).to_not eq([@item_1])
      end
    end

    describe '::disabled' do
      it "returns all items where the status is disabled" do
        expect(@merchant.items.disabled).to eq([@item_1])
        expect(@merchant.items.disabled).to_not eq([@item_2, @item_3, @item_4])
      end
    end
  end

  describe '::Instance Methods' do
    before(:each) do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @item_3 = create(:item, merchant: @merchant)
      @item_4 = create(:item, merchant: @merchant)
      @item_5 = create(:item, merchant: @merchant)
      @item_6 = create(:item, merchant: @merchant)

      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1))
      @invoice_2 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1))
      @invoice_3 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1))
      @invoice_4 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,2,1))
      @invoice_5 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,2,1))
      @invoice_6 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,3,1))
      @invoice_7 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,4,1))
      @invoice_8 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,5,1))
      @invoice_9 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,6,1))
      @invoice_10 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,7,1))
      @invoice_11 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,8,1))
      @invoice_12 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,9,1))

      create(:transaction, invoice_id: @invoice_1.id, result: 0)
      create(:transaction, invoice_id: @invoice_2.id, result: 0)
      create(:transaction, invoice_id: @invoice_3.id, result: 0)
      create(:transaction, invoice_id: @invoice_4.id, result: 0)
      create(:transaction, invoice_id: @invoice_5.id, result: 0)
      create(:transaction, invoice_id: @invoice_6.id, result: 0)
      create(:transaction, invoice_id: @invoice_7.id, result: 0)
      create(:transaction, invoice_id: @invoice_8.id, result: 0)
      create(:transaction, invoice_id: @invoice_9.id, result: 0)
      create(:transaction, invoice_id: @invoice_10.id, result: 0)
      create(:transaction, invoice_id: @invoice_11.id, result: 0)
      create(:transaction, invoice_id: @invoice_12.id, result: 0)

      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 900, quantity: 3)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, unit_price: 800, quantity: 3)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, unit_price: 700, quantity: 3)
      @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_4, unit_price: 600, quantity: 3)
      @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_5, unit_price: 500, quantity: 3)
      @invoice_item_6 = create(:invoice_item, item: @item_6, invoice: @invoice_6, unit_price: 400, quantity: 3)
      @invoice_item_7 = create(:invoice_item, item: @item_1, invoice: @invoice_7, unit_price: 900, quantity: 2)
      @invoice_item_8 = create(:invoice_item, item: @item_2, invoice: @invoice_8, unit_price: 800, quantity: 2)
      @invoice_item_9 = create(:invoice_item, item: @item_3, invoice: @invoice_9, unit_price: 700, quantity: 2)
      @invoice_item_10 = create(:invoice_item, item: @item_4, invoice: @invoice_10, unit_price: 600, quantity: 2)
      @invoice_item_11 = create(:invoice_item, item: @item_5, invoice: @invoice_11, unit_price: 500, quantity: 2)
      @invoice_item_12 = create(:invoice_item, item: @item_6, invoice: @invoice_12, unit_price: 400, quantity: 2)
    end

    describe '::item_best_day' do
      it 'returns the date with the most sales for the item' do
        expect(@item_1.item_best_day).to_eq('2023-01-01 00:00:00 UTC')
      end
    end
  end
end
