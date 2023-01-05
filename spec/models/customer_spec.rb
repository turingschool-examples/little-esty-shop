require 'rails_helper'

RSpec.describe Customer, type: :model do

  # before(:all) do
  #   Rails.application.load_seed
  # end

  describe 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
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
    
    it 'returns the 5 customers with most successful transactions for a merchant' do
    #  require 'pry';binding.pry
      # expect(@merchant_2.top_customers).to include(@customer_1, @customer_3, @customer_8, @customer_7, @customer_5)
      expect(Customer.top_customers).to include(@customer_1, @customer_3, @customer_8, @customer_7, @customer_5)
      # expect(@merchant_3.top_customers).to_not include(@customer_8)

      # expect(@merchant_3.top_customers).to eq(@customer_2,@customer_3,@customer_5,@customer_6,@customer_7)
    end
end

end