require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
  end

  before(:each) do
    @merchant_1 = create(:merchant, status: "enabled")
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant, status: "disabled")

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)
    @item_7 = create(:item, merchant: @merchant_3)
    @item_8 = create(:item, merchant: @merchant_3)
    @item_9 = create(:item, merchant: @merchant_3)
    @item_10 = create(:item, merchant: @merchant_3)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_1.items << @item_1
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_2.items << @item_2
    @invoice_3 = create(:invoice, customer: @customer_1)
    @invoice_3.items << @item_3
    @invoice_3.items << @item_4
    @invoice_4 = create(:invoice, customer: @customer_2)
    @invoice_4.items << @item_5
    @invoice_4.items << @item_7
  end

  describe 'merchant invoices' do
    it 'returns merchant invoice ids' do
      expect(@merchant_2.all_invoice_ids).to eq([@invoice_2.id, @invoice_3.id, @invoice_4.id])
    end
  end

  describe '#toggle_status' do
    it 'changes merchant status to disabled if currently enabled and the inverse' do
      expect(@merchant_1.status).to eq("enabled")

      @merchant_1.toggle_status

      expect(@merchant_1.status).to eq("disabled")

      @merchant_1.toggle_status

      expect(@merchant_1.status).to eq("enabled")
    end
  end

  describe '#group_by_status' do
    it 'returns merchants based on status argument' do
      enabled_expected_1 = @merchant_1
      enabled_expected_2 = @merchant_2
      enabled_expected_3 = @merchant_3
      disabled_expected_1 = @merchant_4

      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_1)
      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_2)
      expect(Merchant.group_by_status("enabled")).to include(enabled_expected_3)
      expect(Merchant.group_by_status("disabled")).to include(disabled_expected_1)
    end
  end

  describe '#top_five' do
    it 'returns the top five merchants based on total revenue' do
      Transaction.delete_all
      InvoiceItem.delete_all
      Invoice.delete_all
      Item.delete_all
      Customer.delete_all
      Merchant.delete_all

      merchant_1 = create(:merchant, name: "Alpha")
      merchant_2 = create(:merchant, name: "Beta")
      merchant_3 = create(:merchant, name: "Delta")
      merchant_4 = create(:merchant, name: "Epsilon")
      merchant_5 = create(:merchant, name: "Gamma")
      merchant_6 = create(:merchant, name: "Iota")
      merchant_7 = create(:merchant, name: "Kappa")
      merchant_8 = create(:merchant, name: "Lambda")
      merchant_9 = create(:merchant, name: "Omikron")
      merchant_10 = create(:merchant, name: "Pi")
      merchant_11 = create(:merchant, name: "Sigma")
      merchant_12 = create(:merchant, name: "Tau")

      customer_1 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_1)
      invoice_3 = create(:invoice, customer: customer_1)
      invoice_4 = create(:invoice, customer: customer_1)
      invoice_5 = create(:invoice, customer: customer_1)
      invoice_6 = create(:invoice, customer: customer_1)
      invoice_7 = create(:invoice, customer: customer_1)
      invoice_8 = create(:invoice, customer: customer_1)
      invoice_9 = create(:invoice, customer: customer_1)
      invoice_10 = create(:invoice, customer: customer_1)

      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_2)
      item_3 = create(:item, merchant: merchant_3)
      item_4 = create(:item, merchant: merchant_4)
      item_5 = create(:item, merchant: merchant_5)
      item_6 = create(:item, merchant: merchant_6)
      item_7 = create(:item, merchant: merchant_7)
      item_8 = create(:item, merchant: merchant_8)
      item_9 = create(:item, merchant: merchant_9)
      item_10 = create(:item, merchant: merchant_10)

      invoice_item_1 = create(:invoice_item, unit_price: 1000, quantity: 1, item: item_1, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item, unit_price: 900, quantity: 1, item: item_2, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item, unit_price: 800, quantity: 1, item: item_3, invoice: invoice_3)
      invoice_item_4 = create(:invoice_item, unit_price: 700, quantity: 1, item: item_4, invoice: invoice_4)
      invoice_item_5 = create(:invoice_item, unit_price: 600, quantity: 1, item: item_5, invoice: invoice_5)
      invoice_item_6 = create(:invoice_item, unit_price: 500, quantity: 1, item: item_6, invoice: invoice_6)
      invoice_item_7 = create(:invoice_item, unit_price: 400, quantity: 1, item: item_7, invoice: invoice_7)
      invoice_item_8 = create(:invoice_item, unit_price: 300, quantity: 1, item: item_8, invoice: invoice_8)
      invoice_item_9 = create(:invoice_item, unit_price: 200, quantity: 1, item: item_9, invoice: invoice_9)
      invoice_item_10 = create(:invoice_item, unit_price: 100, quantity: 1, item: item_10, invoice: invoice_10)

      transaction_1 = create(:transaction, result: 0, invoice: invoice_1)
      transaction_2 = create(:transaction, result: 0, invoice: invoice_2)
      transaction_3 = create(:transaction, result: 1, invoice: invoice_3)
      transaction_4 = create(:transaction, result: 0, invoice: invoice_4)
      transaction_5 = create(:transaction, result: 0, invoice: invoice_5)
      transaction_6 = create(:transaction, result: 1, invoice: invoice_6)
      transaction_7 = create(:transaction, result: 0, invoice: invoice_7)
      transaction_8 = create(:transaction, result: 0, invoice: invoice_8)
      transaction_9 = create(:transaction, result: 1, invoice: invoice_9)
      transaction_10 = create(:transaction, result: 0, invoice: invoice_10)
      
      expected = [merchant_1, merchant_2, merchant_4, merchant_5, merchant_7]
      expect(Merchant.top_five).to eq(expected)
    end
  end

  describe '#top_five' do
    it 'returns the top five merchants based on total revenue' do
      Transaction.delete_all
      InvoiceItem.delete_all
      Invoice.delete_all
      Item.delete_all
      Customer.delete_all
      Merchant.delete_all

      merchant_1 = create(:merchant, name: "Alpha")

      customer_1 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_1)
      invoice_3 = create(:invoice, customer: customer_1)

      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_1)
      item_3 = create(:item, merchant: merchant_1)
      item_4 = create(:item, merchant: merchant_1)

      invoice_item_1 = create(:invoice_item, unit_price: 1000, quantity: 1, item: item_1, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item, unit_price: 900, quantity: 1, item: item_2, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item, unit_price: 800, quantity: 1, item: item_3, invoice: invoice_3)

      transaction_1 = create(:transaction, result: 0, invoice: invoice_1)
      transaction_2 = create(:transaction, result: 0, invoice: invoice_2)
      transaction_3 = create(:transaction, result: 1, invoice: invoice_3)
      
      expected = 19.00
      expect(merchant_1.total_revenue).to eq(expected)
    end
  end
end