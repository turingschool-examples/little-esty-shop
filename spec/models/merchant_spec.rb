require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'enable/disable item button' do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @customer_1 = create(:customer)
      @item_1 = create(:item, merchant: @merchant_1, status: 0)
      @item_2 = create(:item, merchant: @merchant_1, status: 1)
    end

    it 'can get enabled items' do
      expect(@merchant_1.enabled).to eq([@item_2])
    end

    it 'can get disabled items' do
      expect(@merchant_1.disabled).to eq([@item_1])
    end
  end

  describe 'class methods' do
    it 'can fetch enabled merchants' do
      merchant_1 = create(:merchant, status: true)
      merchant_2 = create(:merchant, status: false)

      expect(Merchant.enabled_merchants).to eq([merchant_1])
    end

    it 'can fetch disabled merchants' do
      merchant_1 = create(:merchant, status: true)
      merchant_2 = create(:merchant, status: false)

      expect(Merchant.disabled_merchants).to eq([merchant_2])
    end
  end

  describe 'Merchant dashboard page' do
    before(:each) do
      @customer = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer, created_at: "Friday, September 17, 2021" )
      @invoice_2 = create(:invoice, customer: @customer, created_at: "Thursday, September 16, 2021")
      @invoice_3 = create(:invoice, customer: @customer, created_at: "Wednesday, September 15, 2021")
      @invoice_4 = create(:invoice, customer: @customer, created_at: "Tuesday, September 14, 2021")
      @merchant = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant, name: "a")
      @item_2 = create(:item, merchant: @merchant, name: "b")
      @item_3 = create(:item, merchant: @merchant_2, name: "c")
      @invoice_item_1 = create(:invoice_item, item: @item_3, status: 0, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, item: @item_2, status: 0,invoice: @invoice_2, created_at: "Thursday, September 16, 2021")
      @invoice_item_3 = create(:invoice_item, item: @item_1, status: 1, invoice: @invoice_3, created_at: "Wednesday, September 15, 2021")
      @invoice_item_3 = create(:invoice_item, item: @item_3, status: 0, invoice: @invoice_4, created_at: "Wednesday, September 15, 2021")
    end

    it 'gets only packaged/pending items' do
      expect(@merchant.packaged_items).to eq([@item_2, @item_1])
    end
  end

  describe 'popular items' do
    it "can list the 5 most popular items" do
      customer = create(:customer)

      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: 'A')
      item_2 = create(:item, merchant: merchant, name: 'B')
      item_3 = create(:item, merchant: merchant, name: 'C')
      item_4 = create(:item, merchant: merchant, name: 'D')
      item_5 = create(:item, merchant: merchant, name: 'E')
      item_6 = create(:item, merchant: merchant, name: 'F')
      item_7 = create(:item, merchant: merchant, name: 'G')
      item_8 = create(:item, merchant: merchant, name: 'H')
      item_9 = create(:item, merchant: merchant, name: 'I')

      invoice_1 = create(:invoice, customer: customer, created_at: "Friday, September 17, 2021" )
      transaction = create(:transaction, result: 'success', invoice: invoice_1)
      invoice_item_1 = create(:invoice_item, item: item_1, status: 2, unit_price: 2, quantity: 2, invoice: invoice_1)

      invoice_2 = create(:invoice, customer: customer, created_at: "Thursday, September 16, 2021")
      transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)
      invoice_item_2 = create(:invoice_item, item: item_2, status: 0, unit_price: 2, quantity: 3, invoice: invoice_2, created_at: "Wednesday, September 15, 2021")

      invoice_3 = create(:invoice, customer: customer, created_at: "Wednesday, September 15, 2021")
      transaction_3 = create(:transaction, result: 'success', invoice: invoice_3)
      invoice_item_3 = create(:invoice_item, item: item_3, status: 2, unit_price: 2, quantity: 4, invoice: invoice_3)

      invoice_4 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_4 = create(:transaction, result: 'success', invoice: invoice_4)
      invoice_item_4 = create(:invoice_item, item: item_4, status: 2, unit_price: 2, quantity: 5, invoice: invoice_4)

      invoice_5 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_5 = create(:transaction, result: 'success', invoice: invoice_5)
      invoice_item_5 = create(:invoice_item, item: item_5, status: 2, unit_price: 2, quantity: 6, invoice: invoice_5)

      invoice_6 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_6 = create(:transaction, result: 'failed', invoice: invoice_6)
      invoice_item_6 = create(:invoice_item, item: item_6, status: 2, unit_price: 100, quantity: 200, invoice: invoice_6)

      invoice_7 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
      transaction_7 = create(:transaction, result: 'failed', invoice: invoice_7)
      invoice_item_7 = create(:invoice_item, item: item_7, status: 2, unit_price: 0, quantity: 0, invoice: invoice_7)

      expect(merchant.top_five_items).to eq([item_5, item_4, item_3, item_2, item_1])
    end
  end
end
