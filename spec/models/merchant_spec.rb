require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @merchant2 = FactoryBot.create(:merchant)

    @item = FactoryBot.create(:item, merchant: @merchant)
    @item2 = FactoryBot.create(:item, merchant: @merchant)
    @item3 = FactoryBot.create(:item, merchant: @merchant)
    @item4 = FactoryBot.create(:item, merchant: @merchant)
    @item5 = FactoryBot.create(:item, merchant: @merchant)
    # edge case
    @item6 = FactoryBot.create(:item, merchant: @merchant2)

    @customer_1 = FactoryBot.create(:customer)
    @customer_2 = FactoryBot.create(:customer)
    @customer_3 = FactoryBot.create(:customer)
    @customer_4 = FactoryBot.create(:customer)
    @customer_5 = FactoryBot.create(:customer)
    @customer_6 = FactoryBot.create(:customer)

    @invoice_1 = FactoryBot.create(:invoice, customer: @customer_1, status: "in progress")
    @invoice_2 = FactoryBot.create(:invoice, customer: @customer_2, status: "in progress")
    @invoice_3 = FactoryBot.create(:invoice, customer: @customer_3, status: "in progress")
    @invoice_4 = FactoryBot.create(:invoice, customer: @customer_4, status: "in progress")
    @invoice_5 = FactoryBot.create(:invoice, customer: @customer_5, status: "in progress")

    @transaction_1 = FactoryBot.create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = FactoryBot.create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_3 = FactoryBot.create(:transaction, invoice: @invoice_1, result: "success")

    @transaction_4 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_5 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_6 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_7 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_8 = FactoryBot.create(:transaction, invoice: @invoice_2, result: "success")

    @transaction_9 = FactoryBot.create(:transaction, invoice: @invoice_3, result: "success")

    @transaction_10 = FactoryBot.create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_11 = FactoryBot.create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_12 = FactoryBot.create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_13 = FactoryBot.create(:transaction, invoice: @invoice_4, result: "success")

    @transaction_14 = FactoryBot.create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_15 = FactoryBot.create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_16 = FactoryBot.create(:transaction, invoice: @invoice_5, result: "failed")

    @invoice_item_1 = FactoryBot.create(:invoice_item, invoice: @invoice_1, item: @item, status: "pending")
    @invoice_item_2 = FactoryBot.create(:invoice_item, invoice: @invoice_2, item: @item2, status: "pending")
    @invoice_item_3 = FactoryBot.create(:invoice_item, invoice: @invoice_3, item: @item3, status: "packaged")
    @invoice_item_4 = FactoryBot.create(:invoice_item, invoice: @invoice_4, item: @item4, status: "packaged")
    @invoice_item_5 = FactoryBot.create(:invoice_item, invoice: @invoice_5, item: @item5, status: "packaged")
  end

  describe '#top_customers' do
    it 'returns the top 5 customers for a merchant' do
      customers = [@customer_2, @customer_4, @customer_1, @customer_5, @customer_3]
      expect(@merchant.top_customers).to eq(customers)
    end
  end

  describe '#ready_items' do
    it 'returns the items which have not yet shipped' do
      items = [@item3, @item4, @item5]
      expect(@merchant.ready_items).to eq(items)
    end
  end

  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe 'instance variables' do
    it 'filters items by status' do
      merchant_1 = FactoryBot.create(:merchant)
      item_1 = FactoryBot.create(:item, status: 0, merchant: merchant_1)
      item_2 = FactoryBot.create(:item, status: 1, merchant: merchant_1)
      item_3 = FactoryBot.create(:item, status: 0, merchant: merchant_1)
      item_4 = FactoryBot.create(:item, status: 1, merchant: merchant_1)

      expect(merchant_1.filter_item_status(0)).to include(item_1, item_1)
      expect(merchant_1.filter_item_status(1)).to include(item_2, item_4)
    end
  end
end
