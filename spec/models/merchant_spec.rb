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
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2020,2,3,4,5,6))
      @items << create(:item, merchant_id: @merchant_1.id, enabled: 0)
      @transactions << create(:transaction, invoice_id: @invoices.last.id)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1)
    end
    3.times do
      @customers << create(:customer)
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2020,2,3,4,5,6))
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

  describe '#best_revenue_day' do
    it 'returns the top revenue day for a given merchant' do
      InvoiceItem.destroy_all
      Item.destroy_all
      Transaction.destroy_all
      Invoice.destroy_all
      Customer.destroy_all
      Merchant.destroy_all

      @customers = []
      @invoices = []
      @items = []
      @transactions = []
      @invoice_items = []

      @merchant_2 = create(:merchant)

      @customers << create(:customer)
      @customers << create(:customer)
      @customers << create(:customer)
      @customers << create(:customer)
      @customers << create(:customer)

      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)
      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)
      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)
      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)
      @items << create(:item, merchant_id: @merchant_2.id, enabled: 0)

      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2020,1,3,4,5,6))
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2019,2,3,4,5,6))
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2018,3,3,4,5,6))
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2017,4,3,4,5,6))
      @invoices << create(:invoice, customer_id: @customers.last.id, status: 2, created_at: DateTime.new(2016,5,3,4,5,6))

      @transactions << create(:transaction, invoice_id: @invoices[0].id)
      @transactions << create(:transaction, invoice_id: @invoices[1].id)
      @transactions << create(:transaction, invoice_id: @invoices[2].id)
      @transactions << create(:transaction, invoice_id: @invoices[3].id)
      @transactions << create(:transaction, invoice_id: @invoices[4].id)

      @invoice_items << create(:invoice_item, item_id: @items[0].id, invoice_id: @invoices[0].id, status: 2, quantity: 4, unit_price: 10)
      @invoice_items << create(:invoice_item, item_id: @items[1].id, invoice_id: @invoices[1].id, status: 2, quantity: 2, unit_price: 10)
      @invoice_items << create(:invoice_item, item_id: @items[2].id, invoice_id: @invoices[2].id, status: 2, quantity: 3, unit_price: 10)
      @invoice_items << create(:invoice_item, item_id: @items[3].id, invoice_id: @invoices[3].id, status: 2, quantity: 4, unit_price: 10)
      @invoice_items << create(:invoice_item, item_id: @items[4].id, invoice_id: @invoices[4].id, status: 2, quantity: 1, unit_price: 10)

      expect(Merchant.best_revenue_day).to eq(@invoices[0].created_at)
    end
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
