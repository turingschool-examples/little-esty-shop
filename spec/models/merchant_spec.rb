require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'Class Methods' do
    before :each do
      @merchant_1 = create(:merchant, name: "merch_11", active_status: :enabled)
      @merchant_2 = create(:merchant, name: "merch_12")
      @merchant_3 = create(:merchant, name: "merch_13", active_status: :enabled)
      @merchant_4 = create(:merchant, name: "merch_14", active_status: :enabled)
      @merchant_5 = create(:merchant, name: "merch_15", active_status: :enabled)
      @merchant_6 = create(:merchant, name: "merch_16")

      #merchant_11 items
      @items_1 = create_list(:item, 10, merchant: @merchant_1)
      @items_2 = create_list(:item, 10, merchant: @merchant_1)
      #merchant_12 items
      @items_3 = create_list(:item, 10, merchant: @merchant_2)
      @items_4 = create_list(:item, 10, merchant: @merchant_2)
      #merchant_13 items
      @items_5 = create_list(:item, 10, merchant: @merchant_3)
      @items_6 = create_list(:item, 10, merchant: @merchant_3)
      #merchant_14 items
      @items_7 = create_list(:item, 10, merchant: @merchant_4)
      @items_8 = create_list(:item, 10, merchant: @merchant_4)
      #merchant_15 items
      @items_9 = create_list(:item, 10, merchant: @merchant_5)
      @items_10 = create_list(:item, 10, merchant: @merchant_5)
      #merchant_16 items
      @items_11 = create_list(:item, 10, merchant: @merchant_6)
      @items_12 = create_list(:item, 10, merchant: @merchant_6)

      @invoice_2 = create(:invoice)
      @invoice_1 = create(:invoice)
      @invoice_3 = create(:invoice)
      @invoice_4 = create(:invoice)
      @invoice_5 = create(:invoice)
      @invoice_6 = create(:invoice)
      @invoice_7 = create(:invoice)
      @invoice_8 = create(:invoice)

      @items_1.each { |item| create(:invoice_items, invoice: @invoice_1, item: item, unit_price: 500, quantity: 10) } #50000
      @items_2.each { |item| create(:invoice_items, invoice: @invoice_2, item: item, unit_price: 100, quantity: 5) } #5000
      @items_3.each { |item| create(:invoice_items, invoice: @invoice_3, item: item, unit_price: 500, quantity: 5) } #25000
      @items_4.each { |item| create(:invoice_items, invoice: @invoice_4, item: item, unit_price: 200, quantity: 10) } # 20000
      @items_5.each { |item| create(:invoice_items, invoice: @invoice_5, item: item, unit_price: 500, quantity: 10) } #50000
      @items_6.each { |item| create(:invoice_items, invoice: @invoice_6, item: item, unit_price: 200, quantity: 5) } #10000
      @items_7.each { |item| create(:invoice_items, invoice: @invoice_7, item: item, unit_price: 100, quantity: 10) } #10000
      @items_8.each { |item| create(:invoice_items, invoice: @invoice_8, item: item, unit_price: 200, quantity: 5) } #10000
      @items_9.each { |item| create(:invoice_items, invoice: @invoice_3, item: item, unit_price: 500, quantity: 15) } #50000
      @items_10.each { |item| create(:invoice_items, invoice: @invoice_2, item: item, unit_price: 100, quantity: 5) } #5000
      @items_11.each { |item| create(:invoice_items, invoice: @invoice_5, item: item, unit_price: 500, quantity: 20) } #50000
      @items_12.each { |item| create(:invoice_items, invoice: @invoice_6, item: item, unit_price: 200, quantity: 10) } #10000

      @transaction_1 = create_list(:transaction, 5, invoice: @invoice_1, result: :failed)
      @transaction_2 = create_list(:transaction, 5, invoice: @invoice_2, result: :failed)
      @transaction_3 = create_list(:transaction, 5, invoice: @invoice_3, result: :success)
      @transaction_4 = create_list(:transaction, 5, invoice: @invoice_4, result: :success)
      @transaction_5 = create_list(:transaction, 5, invoice: @invoice_5, result: :success)
      @transaction_6 = create_list(:transaction, 5, invoice: @invoice_6, result: :success)
      @transaction_7 = create_list(:transaction, 5, invoice: @invoice_7, result: :success)
      @transaction_8 = create_list(:transaction, 5, invoice: @invoice_8, result: :success)
    end
    it "#active" do
      expect(Merchant.active).to eq([@merchant_11, @merchant_13, @merchant_14, @merchant_15])      
    end

    it "#inactive" do
      expect(Merchant.inactive).to eq([@merchant_12, @merchant_16])      
    end

    it 'top_5_order_by_revenue' do
      expect(Merchant.order_by_revenue).to eq([@merchant_16, @merchant_15, @merchant_13, @merchant_12, @merchant_14])
    end
  end

  describe 'Instance Methods' do 
    before :each do
      @merchant = create(:merchant)
      @merchant_13 = create(:merchant)

      @items_11 = create_list(:item, 10, merchant: @merchant)
      @items_12 = create_list(:item, 10, merchant: @merchant)
      @items_13 = create_list(:item, 10, merchant: @merchant_13)

      @invoice_11 = create(:invoice)
      @invoice_12 = create(:invoice)
      @invoice_13 = create(:invoice)

      @items_11.each { |item| create(:invoice_items, invoice: @invoice_11, item: item, unit_price: 500, quantity: 10) }
      @items_12.each { |item| create(:invoice_items, invoice: @invoice_12, item: item, unit_price: 100, quantity: 5) }

      @items_13.each { |item| create(:invoice_items, invoice: @invoice_13, item: item, unit_price: 200, quantity: 5) }

      @transaction_11 = create_list(:transaction, 5, invoice: @invoice_11, result: :success)
      @transaction_12 = create_list(:transaction, 5, invoice: @invoice_11, result: :failed)
      @transaction_13 = create_list(:transaction, 5, invoice: @invoice_12, result: :success)
      @transaction_14 = create_list(:transaction, 5, invoice: @invoice_12, result: :failed)

      @transaction_15 = create_list(:transaction, 10, invoice: @invoice_13, result: :failed)

      @merchant1 = create(:merchant)

      @item_1 = create(:item, merchant: @merchant1)
      @item_2 = create(:item, merchant: @merchant1)

      @invoice_1 = create(:invoice, created_at: "10-10-1999")
      @invoice_2 = create(:invoice, created_at: "10-10-1975")
      @invoice_3 = create(:invoice, created_at: "10-10-1934")
      @invoice_4 = create(:invoice, created_at: "10-10-2021")
      @invoice_5 = create(:invoice, created_at: "10-10-1955")
      @invoice_6 = create(:invoice, created_at: "10-10-1992")

      create(:invoice_items, invoice: @invoice_1, item: @item_1, status: :shipped)
      create(:invoice_items, invoice: @invoice_2, item: @item_1, status: :shipped)
      create(:invoice_items, invoice: @invoice_3, item: @item_1, status: :shipped)
      create(:invoice_items, invoice: @invoice_4, item: @item_1, status: :pending)
      create(:invoice_items, invoice: @invoice_5, item: @item_1, status: :pending)
      create(:invoice_items, invoice: @invoice_6, item: @item_1, status: :pending)

      create(:invoice_items, invoice: @invoice_1, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_2, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_3, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_4, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_5, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_6, item: @item_2, status: :shipped)
    end

    it 'has items_not_shipped method' do
      expect(@merchant1.items_not_shipped_sorted_by_date).to eq([@invoice_5, @invoice_6, @invoice_4])
    end

    it '#invoices_distinct_by_merchant' do
      # expect(@merchant1.invoices_distinct_by_merchant).to eq([@invoice_1, @invoice_2, @invoice_3,@invoice_4, @invoice_5, @invoice_6])
    end

    it 'total_revenue' do
      expect(@merchant.total_revenue).to eq(55000)
      expect(@merchant_13.total_revenue).to eq(0)
    end
  end
end