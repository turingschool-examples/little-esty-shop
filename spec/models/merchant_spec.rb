require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'Class Methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Johns Tools", active_status: :enabled)
      @merchant_2 = Merchant.create!(name: "Hannas Hammocks", active_status: :enabled)
      @merchant_3 = Merchant.create!(name: "Pretty Plumbing")
      @merchant_4 = Merchant.create!(name: "Jenna's Jewlery", active_status: :enabled)
      @merchant_5 = Merchant.create!(name: "Sassy Soap")
      @merchant_6 = Merchant.create!(name: "Tom's Typewriters")

      @merchant_11 = create(:merchant)
      @merchant_12 = create(:merchant)
      @merchant_13 = create(:merchant)
      @merchant_14 = create(:merchant)

      #merchant_11 items
      @items_11 = create_list(:item, 10, merchant: @merchant_11)
      @items_12 = create_list(:item, 10, merchant: @merchant_11)
      #merchant_12 items
      @items_13 = create_list(:item, 10, merchant: @merchant_12)
      @items_14 = create_list(:item, 10, merchant: @merchant_12)
      #merchant_13 items
      @items_15 = create_list(:item, 10, merchant: @merchant_13)
      @items_16 = create_list(:item, 10, merchant: @merchant_13)
      #merchant_14 items
      @items_15 = create_list(:item, 10, merchant: @merchant_14)
      @items_16 = create_list(:item, 10, merchant: @merchant_14)

      @invoice_11 = create(:invoice)
      @invoice_12 = create(:invoice)
      @invoice_13 = create(:invoice)

      #merchant_11 items - revenue: 55000
      @items_11.each { |item| create(:invoice_items, invoice: @invoice_11, item: item, unit_price: 500, quantity: 10) } #50000
      @items_12.each { |item| create(:invoice_items, invoice: @invoice_12, item: item, unit_price: 100, quantity: 5) } #5000
      #merchant_12 items - revenue: 45000
      @items_13.each { |item| create(:invoice_items, invoice: @invoice_13, item: item, unit_price: 500, quantity: 5) } #25000
      @items_14.each { |item| create(:invoice_items, invoice: @invoice_11, item: item, unit_price: 200, quantity: 10) } # 20000
      #merchant_13 items - revenue:60000
      @items_15.each { |item| create(:invoice_items, invoice: @invoice_12, item: item, unit_price: 500, quantity: 10) } #50000
      @items_16.each { |item| create(:invoice_items, invoice: @invoice_13, item: item, unit_price: 200, quantity: 5) } #10000
      #merchant_14 items - revenue:20000
      @items_15.each { |item| create(:invoice_items, invoice: @invoice_12, item: item, unit_price: 100, quantity: 10) } #10000
      @items_16.each { |item| create(:invoice_items, invoice: @invoice_13, item: item, unit_price: 200, quantity: 5) } #10000
    end

    it "#active" do
      expect(Merchant.active).to eq([@merchant_1, @merchant_2, @merchant_4])      
    end

    it "#inactive" do
      expect(Merchant.inactive).to eq([@merchant_3, @merchant_5, @merchant_6])      
    end

    it 'order_by_revenue' do
      expect(Merchant.order_by_revenue).to eq([@merchant_13, @merchant_12, @merchant_11, @merchant_14@])
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
      expect(@merchant2.items_not_shipped_sorted_by_date).to eq([@invoice_3, @invoice_2, @invoice_1])
    end

    it '#invoices_distinct_by_merchant' do
      expect(@merchant1.invoices_distinct_by_merchant).to eq([@invoice_1, @invoice_2, @invoice_3,@invoice_4, @invoice_5, @invoice_6])
    end

    it 'total_revenue' do
      expect(@merchant.total_revenue).to eq(55000)
      expect(@merchant_13.total_revenue).to eq(0)
    end
  end
end