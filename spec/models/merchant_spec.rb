require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant, name: "testing merchant")

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
    @item_11 = create(:item, name: "testing item", merchant: @merchant_4)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @customer_7 = create(:customer)
    @customer_8 = create(:customer)
    @customer_9 = create(:customer, first_name: "testing customer")

    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_1.items << @item_1
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_2.items << @item_2
    @invoice_3 = create(:invoice, customer: @customer_1)
    @invoice_3.items << [@item_3, @item_4]
    @invoice_4 = create(:invoice, customer: @customer_2)
    @invoice_4.items << [@item_5, @item_7]
    
    @invoice_5 = create(:invoice, customer: @customer_3)
    @invoice_5.items << [@item_2, @item_3, @item_6, @item_8]
    @invoice_6 = create(:invoice, customer: @customer_3)
    @invoice_6.items << [@item_2, @item_2, @item_4, @item_6]
    @invoice_7 = create(:invoice, customer: @customer_4)
    @invoice_7.items << [@item_1, @item_1, @item_10]
    @invoice_8 = create(:invoice, customer: @customer_5)
    @invoice_8.items << [@item_5, @item_7, @item_10]
    
    @invoice_9= create(:invoice, customer: @customer_6)
    @invoice_9.items << [@item_4, @item_7, @item_10]
    @invoice_10 = create(:invoice, customer: @customer_7)
    @invoice_10.items << [@item_3, @item_4, @item_5, @item_6]
    @invoice_11 = create(:invoice, customer: @customer_7)
    @invoice_11.items << [@item_1, @item_10]
    @invoice_12 = create(:invoice, customer: @customer_8)
    @invoice_12.items << [@item_2, @item_3, @item_4, @item_5, @item_5, @item_6, @item_6]
    @invoice_13 = create(:invoice, status: "completed", customer: @customer_9)
    @invoice_13.items << [@item_11]
    @invoice_14 = create(:invoice, status: "completed", customer: @customer_8)
    @invoice_14.items << [@item_11, @item_11]

    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: "failed")
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: "success")
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: "success")
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: "success")
    @transaction_9 = create(:transaction, invoice: @invoice_9, result: "failed")
    @transaction_10 = create(:transaction, invoice: @invoice_10, result: "success")
    @transaction_11 = create(:transaction, invoice: @invoice_11, result: "success")
    @transaction_12 = create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_13 = create(:transaction, invoice: @invoice_9, result: "success")
    @transaction_14 = create(:transaction, invoice: @invoice_12, result: "failed")
    @transaction_15 = create(:transaction, invoice: @invoice_13, result: "success")
    @transaction_16 = create(:transaction, invoice: @invoice_14, result: "success")
  end

  describe 'merchant invoices' do
    it 'returns merchant invoice ids' do
      expect(@merchant_2.all_invoice_ids).to eq([@invoice_2.id, @invoice_3.id, @invoice_4.id, @invoice_5.id, @invoice_6.id, @invoice_8.id, @invoice_9.id, @invoice_10.id, @invoice_12.id])
    end
  end
end