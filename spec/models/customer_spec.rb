require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  it 'has a method to find the top 5 customers by successful invoices' do
    result = [Customer.third, Customer.fifth, Customer.second, Customer.fourth, Customer.last]
    expect(Customer.top_5_transactions).to eq(result)
  end

  it 'has a method to find the number of successful transactions for a customer' do
    expect(Customer.third.successful_transactions_count).to eq(5)
  end

  describe "merchant's top 5 customers by transactions"do
    before(:each) do
      Transaction.delete_all
      InvoiceItem.delete_all
      Invoice.delete_all
      Item.delete_all
      Customer.delete_all
      Merchant.delete_all

      @merchant_1 = create(:merchant, name: "testing 1")
      @merchant_2 = create(:merchant, name: "testing 2")
      @merchant_3 = create(:merchant, name: "testing 3")
      @merchant_4 = create(:merchant, name: "testing 4")

      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_2)
      @item_4 = create(:item, merchant: @merchant_2)
      @item_5 = create(:item, merchant: @merchant_2)
      @item_6 = create(:item, merchant: @merchant_2)
      @item_7 = create(:item, merchant: @merchant_3)
      @item_8 = create(:item, merchant: @merchant_3)
      @item_9 = create(:item, merchant: @merchant_3)
      @item_10 = create(:item, merchant: @merchant_3)
      @item_11 = create(:item, name: "testing item", merchant: @merchant_4)

      @customer_1 = create(:customer, first_name: "test customer 1", last_name: "doe")
      @customer_2 = create(:customer, first_name: "test customer 2")
      @customer_3 = create(:customer, first_name: "test customer 3")
      @customer_4 = create(:customer, first_name: "test customer 4")
      @customer_5 = create(:customer, first_name: "test customer 5")
      @customer_6 = create(:customer, first_name: "test customer 6")
      @customer_7 = create(:customer, first_name: "test customer 7")
      @customer_8 = create(:customer, first_name: "test customer 8")
      @customer_9 = create(:customer, first_name: "test customer 9")

      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_1.items << @item_1
      @invoice_2 = create(:invoice, customer: @customer_7)
      @invoice_2.items << @item_2
      @invoice_3 = create(:invoice, customer: @customer_8)
      @invoice_3.items << [@item_3, @item_4]
      @invoice_4 = create(:invoice, customer: @customer_2)
      @invoice_4.items << [@item_5, @item_7]
      @invoice_5 = create(:invoice, customer: @customer_7)
      @invoice_5.items << [@item_2, @item_3, @item_6, @item_8]
      @invoice_6 = create(:invoice, customer: @customer_3)
      @invoice_6.items << [@item_2, @item_2, @item_4, @item_6]
      @invoice_7 = create(:invoice, customer: @customer_4)
      @invoice_7.items << [@item_1, @item_1, @item_10]
      @invoice_8 = create(:invoice, customer: @customer_5)
      @invoice_8.items << [@item_5, @item_7, @item_10]
      @invoice_9= create(:invoice, customer: @customer_4)
      @invoice_9.items << [@item_4, @item_7, @item_10]
      @invoice_10 = create(:invoice, customer: @customer_1)
      @invoice_10.items << [@item_3, @item_4, @item_5, @item_6]
      @invoice_11 = create(:invoice, customer: @customer_7)
      @invoice_11.items << [@item_1, @item_10]
      @invoice_12 = create(:invoice, customer: @customer_8)
      @invoice_12.items << [@item_2, @item_3, @item_4, @item_5, @item_5, @item_6, @item_6]
      @invoice_13 = create(:invoice, status: "completed", customer: @customer_9)
      @invoice_13.items << [@item_11]
      @invoice_14 = create(:invoice, status: "completed", customer: @customer_1)
      @invoice_14.items << [@item_11, @item_11]
      @invoice_15 = create(:invoice, customer: @customer_8)
      @invoice_15.items << [@item_1]
      @invoice_16 = create(:invoice, customer: @customer_7)
      @invoice_16.items << [@item_1]

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
      @transaction_12 = create(:transaction, invoice: @invoice_12, result: "success")
      @transaction_13 = create(:transaction, invoice: @invoice_13, result: "success")
      @transaction_14 = create(:transaction, invoice: @invoice_14, result: "success")
      @transaction_15 = create(:transaction, invoice: @invoice_15, result: "success")
      @transaction_16 = create(:transaction, invoice: @invoice_16, result: "success")
      @transaction_17 = create(:transaction, invoice: @invoice_5, result: "success")
      @transaction_18 = create(:transaction, invoice: @invoice_9, result: "success")
    end
    
    it "returns the customer' first and last names as a singular, complete name" do
      expect(@customer_1.complete_name).to eq("test customer 1 doe")
    end
  end

end