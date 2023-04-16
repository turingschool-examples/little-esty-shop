require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "class methods" do
    before(:each) do
      @merchant_1 = create(:merchant, name: "Z", is_enabled: true)
      @merchant_2 = create(:merchant, name: "A", is_enabled: true)
      @merchant_3 = create(:merchant, name: "Z")
      @merchant_4 = create(:merchant, name: "A")
    end

    describe ".all_enabled" do
      it 'returns a list of all enabled merchants sorted by name A-Z' do
        expect(Merchant.all_enabled).to eq([@merchant_2, @merchant_1])
      end
    end

    describe ".all_disabled" do
      it 'returns a list of all disabled merchants sorted by name A-Z' do
        expect(Merchant.all_disabled).to eq([@merchant_4, @merchant_3])
      end
    end
  end

  describe "instance methods" do
    describe "#enabled_status" do
      it "returns enabled if is_enabled is true" do
        merchant = create(:merchant, is_enabled: true)
        expect(merchant.enabled_status).to eq("Enabled")
      end
      it "returns disabled if is_enabled is false" do
        merchant = create(:merchant, is_enabled: false)
        expect(merchant.enabled_status).to eq("Disabled")
      end
    end

    describe "#highest_revenue_date" do
      it 'returns the date of the invoice with the greatest revenue for the given merchant' do
        customer = create(:customer)
        merchant = create(:merchant)

        invoice_1 = create(:invoice, created_at: '2023-01-01 20:54:10 UTC', customer: customer) # has only successful transactions
        invoice_2 = create(:invoice, created_at: '2023-01-02 20:54:10 UTC', customer: customer) # has 2 successful transactions and 1 un-successful transaction
        invoice_3 = create(:invoice, created_at: '2023-01-03 20:54:10 UTC', customer: customer) # has no successful transactions

        item_1 = create(:item, merchant: merchant)
        item_2 = create(:item, merchant: merchant)
        item_3 = create(:item, merchant: merchant)

        transaction_1 = create(:transaction, result: true, invoice: invoice_1)
        transaction_2 = create(:transaction, result: true, invoice: invoice_1)
        transaction_3 = create(:transaction, result: true, invoice: invoice_1)
        transaction_4 = create(:transaction, result: true, invoice: invoice_2)
        transaction_5 = create(:transaction, result: true, invoice: invoice_2)
        transaction_6 = create(:transaction, result: false, invoice: invoice_2)
        transaction_7 = create(:transaction, result: false, invoice: invoice_3)
        transaction_8 = create(:transaction, result: false, invoice: invoice_3)
        transaction_9 = create(:transaction, result: false, invoice: invoice_3)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 100)
        invoice_item_2= create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 100, unit_price: 10)
        invoice_item_3 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_3.id, quantity: 5, unit_price: 50)
        invoice_item_4 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, quantity: 0, unit_price: 0)
        invoice_item_5= create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, quantity: 6, unit_price: 6)
        invoice_item_6 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 5, unit_price: 4)
        invoice_item_7 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_1.id, quantity: 2, unit_price: 100)
        invoice_item_8= create(:invoice_item, invoice_id: invoice_3.id, item_id: item_2.id, quantity: 100, unit_price: 10)
        invoice_item_9 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item_3.id, quantity: 5, unit_price: 50)

        expect(merchant.highest_revenue_date).to eq(invoice_1.created_at)
      end
    end
  end
end
