require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'instance methods' do
    before(:each) do
      @merch1 = create(:merchant)
      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)
      @cust4 = create(:customer)
      @cust5 = create(:customer)
      @cust6 = create(:customer)
      @item1 = create(:item, merchant: @merch1)
      @item2 = create(:item, merchant: @merch1)
      @item3 = create(:item, merchant: @merch1)
      @invoice1 = create(:invoice, customer: @cust1)
      @invoice2 = create(:invoice, customer: @cust2)
      @invoice3 = create(:invoice, customer: @cust3)
      @invoice4 = create(:invoice, customer: @cust4)
      @invoice5 = create(:invoice, customer: @cust5)
      @invoice6 = create(:invoice, customer: @cust6)
      InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1)
      InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1)
      InvoiceItem.create(item: @item3, invoice: @invoice2, status: 1)
      InvoiceItem.create(item: @item1, invoice: @invoice2)
      InvoiceItem.create(item: @item1, invoice: @invoice3)
      InvoiceItem.create(item: @item1, invoice: @invoice4)
      InvoiceItem.create(item: @item1, invoice: @invoice5)
      InvoiceItem.create(item: @item1, invoice: @invoice6)
      create(:transaction, invoice: @invoice1, result: 'success')
      create(:transaction, invoice: @invoice1, result: 'failed')
      create(:transaction, invoice: @invoice1, result: 'failed')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice2, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice3, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice4, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice5, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
      create(:transaction, invoice: @invoice6, result: 'success')
    end

    it '#favorite_customers' do
      expect(@merch1.favorite_customers).to eq([@cust2, @cust6, @cust4, @cust3, @cust5])
    end

    it '#items_ready_to_ship' do
      expect(@merch1.items_ready_to_ship).to eq([@item1, @item2, @item3])
    end
  end
end
