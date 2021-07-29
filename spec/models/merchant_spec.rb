require 'rails_helper'

RSpec.describe Merchant do
  before(:each) do
    @merchant_1 = create(:merchant)

    @customers = []
    @invoices = []
    @items = []
    @items_2 = []
    @transactions = []
    @invoice_items = []

    2.times do
      @customers << create(:customer)
      @invoices << create(:invoice, customer_id: @customers.last.id)
      @items << create(:item, merchant_id: @merchant_1.id, enabled: 0)
      @transactions << create(:transaction, invoice_id: @invoices.last.id)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
    end
    3.times do
      @customers << create(:customer)
      @invoices << create(:invoice, customer_id: @customers.last.id)
      @items_2 << create(:item, merchant_id: @merchant_1.id, enabled: 1)
      @transactions << create(:transaction, invoice_id: @invoices.last.id)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 2)
    end
  end
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'instance methods' do
    it 'collects enabled items' do
      expect(@merchant_1.enabled_items).to eq(@items)
    end

    it 'collects disabled items' do
      expect(@merchant_1.disabled_items).to eq(@items_2)
    end
  end
end
