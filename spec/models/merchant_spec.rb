require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)

    @merchant_2 = create(:merchant)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)

    @invoice_1.items << [@item_1, @item_2, @item_3]
    @invoice_2.items << [@item_3, @item_4]
    @invoice_3.items << [@item_1, @item_4]
    @invoice_4.items << @item_2
  end

  describe '.invoices' do
    it 'returns a list of invoices which contain an item from the merchant' do
      expect(@merchant_1.distinct_invoices).to match_array([@invoice_1, @invoice_3, @invoice_4])
      expect(@merchant_2.distinct_invoices).to match_array([@invoice_1, @invoice_2, @invoice_3])
    end
  end

  describe 'test instance variables for .top_five_revenue' do
    before(:each) do
      @merch1 = create(:merchant)
      @item1 = create(:item, merchant: @merch1, unit_price: 5700)
      @item2 = create(:item, merchant: @merch1)
  
      @merch2 = create(:merchant)
      @item3 = create(:item, merchant: @merch2, unit_price: 500)
      @item4 = create(:item, merchant: @merch2, unit_price: 500)
      @item5 = create(:item, merchant: @merch2, unit_price: 500)
      @item6 = create(:item, merchant: @merch2, unit_price: 500)
      @item7 = create(:item, merchant: @merch2, unit_price: 500)
      @item8 = create(:item, merchant: @merch2, unit_price: 500)
      @item9 = create(:item, merchant: @merch2, unit_price: 500)
  
      @invoice1 = create(:invoice, status: :completed)
      @invoice2 = create(:invoice, status: :completed)
      @invoice3 = create(:invoice, status: :completed)
      @invoice4 = create(:invoice, status: :completed)
      @invoice5 = create(:invoice, status: :completed)
  
      @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 10, unit_price: 100, status: :packaged)
      @inv_item2 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 11, unit_price: 100, status: :packaged)
      @inv_item3 = create(:invoice_item, invoice: @invoice3, item: @item5, quantity: 12, unit_price: 100, status: :packaged)
      @inv_item4 = create(:invoice_item, invoice: @invoice4, item: @item6, quantity: 13, unit_price: 100, status: :packaged)
      @inv_item5 = create(:invoice_item, invoice: @invoice5, item: @item7, quantity: 14, unit_price: 100, status: :packaged)
      @inv_item6 = create(:invoice_item, invoice: @invoice1, item: @item8, quantity: 15, unit_price: 100, status: :packaged)
      @inv_item7 = create(:invoice_item, invoice: @invoice2, item: @item9, quantity: 16, unit_price: 100, status: :packaged)
      @inv_item8 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 10, unit_price: 100, status: :packaged)
      @inv_item9 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 11, unit_price: 100, status: :packaged)
      @inv_item10 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 12, unit_price: 100, status: :packaged)
  
      @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: :success)
      @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: :failed)
      @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: :success)
      @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: :success)
      @transaction5 = create(:transaction, invoice_id: @invoice5.id, result: :success)
      @transaction6 = create(:transaction, invoice_id: @invoice1.id, result: :success)
      @transaction7 = create(:transaction, invoice_id: @invoice2.id, result: :failed)
      @transaction8 = create(:transaction, invoice_id: @invoice3.id, result: :failed)
      @transaction9 = create(:transaction, invoice_id: @invoice4.id, result: :failed)
      @transaction10 = create(:transaction, invoice_id: @invoice5.id, result: :failed)
    end

    it '.top_five_revenue' do
      expect(@merch2.top_five_revenue).to match_array([@item5, @item7, @item3, @item6, @item8])
      expect(@merch2.top_five_revenue).to eq([@item3, @item8, @item5, @item7, @item6])
    end
  end
end
