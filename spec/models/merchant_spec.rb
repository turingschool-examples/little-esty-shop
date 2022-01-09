require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    let!(:merchant_1) {FactoryBot.create(:merchant)}
    let!(:merchant_2) {FactoryBot.create(:merchant)}

    let!(:item_1) {FactoryBot.create(:item, merchant: merchant_1, status: "disabled")}
    let!(:item_2) {FactoryBot.create(:item, merchant: merchant_1, status: "enabled")}
    let!(:item_3) {FactoryBot.create(:item, merchant: merchant_1, status: "disabled")}
    let!(:item_4) {FactoryBot.create(:item, merchant: merchant_1, status: "enabled")}
    let!(:item_5) {FactoryBot.create(:item, merchant: merchant_1)}
    let!(:item_6) {FactoryBot.create(:item, merchant: merchant_2)}

    let!(:customer_1) {FactoryBot.create(:customer)}
    let!(:customer_2) {FactoryBot.create(:customer)}
    let!(:customer_3) {FactoryBot.create(:customer)}
    let!(:customer_4) {FactoryBot.create(:customer)}
    let!(:customer_5) {FactoryBot.create(:customer)}
    let!(:customer_6) {FactoryBot.create(:customer)}

    let!(:invoice_1) {FactoryBot.create(:invoice, customer: customer_1, status: "in progress")}
    let!(:invoice_2) {FactoryBot.create(:invoice, customer: customer_2, status: "in progress")}
    let!(:invoice_3) {FactoryBot.create(:invoice, customer: customer_3, status: "in progress")}
    let!(:invoice_4) {FactoryBot.create(:invoice, customer: customer_4, status: "in progress")}
    let!(:invoice_5) {FactoryBot.create(:invoice, customer: customer_5, status: "in progress")}

    let!(:transaction_1) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}
    let!(:transaction_2) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}
    let!(:transaction_3) {FactoryBot.create(:transaction, invoice: invoice_1, result: "success")}

    let!(:transaction_4) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
    let!(:transaction_5) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
    let!(:transaction_6) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
    let!(:transaction_7) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}
    let!(:transaction_8) {FactoryBot.create(:transaction, invoice: invoice_2, result: "success")}

    let!(:transaction_9) {FactoryBot.create(:transaction, invoice: invoice_3, result: "success")}

    let!(:transaction_10) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
    let!(:transaction_11) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
    let!(:transaction_12) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}
    let!(:transaction_13) {FactoryBot.create(:transaction, invoice: invoice_4, result: "success")}

    let!(:transaction_14) {FactoryBot.create(:transaction, invoice: invoice_5, result: "success")}
    let!(:transaction_15) {FactoryBot.create(:transaction, invoice: invoice_5, result: "success")}
    let!(:transaction_16) {FactoryBot.create(:transaction, invoice: invoice_5, result: "failed")}

    let!(:invoice_item_1) {FactoryBot.create(:invoice_item, invoice: invoice_1, item: item_1, status: "pending")}
    let!(:invoice_item_2) {FactoryBot.create(:invoice_item, invoice: invoice_2, item: item_2, status: "pending")}
    let!(:invoice_item_3) {FactoryBot.create(:invoice_item, invoice: invoice_3, item: item_3, status: "packaged")}
    let!(:invoice_item_4) {FactoryBot.create(:invoice_item, invoice: invoice_4, item: item_4, status: "packaged")}
    let!(:invoice_item_5) {FactoryBot.create(:invoice_item, invoice: invoice_5, item: item_5, status: "packaged")}

    describe '#top_customers' do
      it 'returns the top 5 customers for a merchant' do
        customers = [customer_2, customer_4, customer_1, customer_5, customer_3]
        expect(merchant_1.top_customers).to eq(customers)
      end
    end
    describe '#ready_items' do
      it 'returns the items which have not yet shipped' do
        items = [item_3, item_4, item_5]
        expect(merchant_1.ready_items).to eq(items)
      end
    end
    describe '#filter_item_status' do
      it 'filters items by status' do
        expect(merchant_1.filter_item_status(0)).to include(item_1, item_1)
        expect(merchant_1.filter_item_status(1)).to include(item_2, item_4)
      end
    end

  describe "#top_items" do
    it 'returns the top 5 items for a merchant ranked by total revenue generated' do
      before (:each) do
        @merch_1 = Merchant.create!(name: "Cat Stuff")
        @merch_2 = Merchant.create!(name: "Dog Stuff")

        @cust1 = FactoryBot.create(:customer)
        @cust2 = FactoryBot.create(:customer)
        @cust3 = FactoryBot.create(:customer)

        @inv1 = @cust1.invoices.create!(status: 1)
        @tran1 = FactoryBot.create(:transaction, invoice: @inv1,  result: 1)

        @inv2 = @cust1.invoices.create!(status: 1)
        @tran2 = FactoryBot.create(:transaction, invoice: @inv2,  result: 1)

        @inv3 = @cust2.invoices.create!(status: 1)
        @tran3 = FactoryBot.create(:transaction, invoice: @inv3,  result: 1)

        @inv4 = @cust2.invoices.create!(status: 1)
        @tran4 = FactoryBot.create(:transaction, invoice: @inv4,  result: 1)

        @inv5 = @cust3.invoices.create!(status: 1)
        @tran5 = FactoryBot.create(:transaction, invoice: @inv5,  result: 1)

        @inv6 = @cust3.invoices.create!(status: 0)
        @tran6 = FactoryBot.create(:transaction, invoice: @inv6,  result: 1)

        @inv7 = @cust3.invoices.create!(status: 1)
        @tran7 = FactoryBot.create(:transaction, invoice: @inv7,  result: 0)

        @inv8 = @cust3.invoices.create!(status: 0)
        @tran8 = FactoryBot.create(:transaction, invoice: @inv8,  result: 0)

        @item1 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 100)
        @item2 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 200)
        @item3 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 300)
        @item4 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 400)
        @item5 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 500)
        @item6 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 600)
        @item7 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 700)
        @item8 = FactoryBot.create(:item, merchant: @merch_2, unit_price: 10000)

        @ii_1 = InvoiceItem.create!(invoice: @inv1, item: @item7, quantity: 20, unit_price: 700, status: "pending")
        @ii_2 = InvoiceItem.create!(invoice: @inv1, item: @item5, quantity: 10, unit_price: 500, status: "pending")
        @ii_3 = InvoiceItem.create!(invoice: @inv2, item: @item7, quantity: 20, unit_price: 700, status: "pending")
        @ii_4 = InvoiceItem.create!(invoice: @inv2, item: @item5, quantity: 10, unit_price: 500, status: "pending")
        @ii_4 = InvoiceItem.create!(invoice: @inv2, item: @item1, quantity: 30, unit_price: 100, status: "pending")
        @ii_5 = InvoiceItem.create!(invoice: @inv3, item: @item4, quantity: 3, unit_price: 400, status: "pending")
        @ii_6 = InvoiceItem.create!(invoice: @inv3, item: @item1, quantity: 30, unit_price: 100, status: "pending")
        @ii_7 = InvoiceItem.create!(invoice: @inv3, item: @item2, quantity: 5, unit_price: 200, status: "pending")
        @ii_8 = InvoiceItem.create!(invoice: @inv4, item: @item3, quantity: 5, unit_price: 300, status: "pending")
        @ii_9 = InvoiceItem.create!(invoice: @inv5, item: @item3, quantity: 5, unit_price: 300, status: "pending")
        @ii_10 = InvoiceItem.create!(invoice: @inv5, item: @item6, quantity: 1, unit_price: 600, status: "pending")

        @ii_11 = InvoiceItem.create!(invoice: @inv6, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
        @ii_12 = InvoiceItem.create!(invoice: @inv7, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
        @ii_13 = InvoiceItem.create!(invoice: @inv8, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
        @ii_14 = InvoiceItem.create!(invoice: @inv8, item: @item8, quantity: 2000, unit_price: 10000, status: "pending")
      end
       
        top_5_items = [@item7, @item5, @item1, @item3, @item4]
        expect(@merch_1.top_items).to eq(top_5_items)
    end

  describe "class methods" do
    let!(:merchant_enabled) {FactoryBot.create(:merchant, status: "enabled")}
    let!(:merchant_disabled) {FactoryBot.create(:merchant, status: "disabled")}

    describe "filter_merchant_status" do
      it 'filters merchants by status' do
        expect(Merchant.filter_merchant_status(0)).to eq([merchant_disabled])
        expect(Merchant.filter_merchant_status(1)).to eq([merchant_enabled])
      end
    end
  end
end
