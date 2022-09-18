require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
  end

  describe 'instance variables' do

    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)

      @merchant_2 = create(:merchant)
      @item_3 = create(:item, merchant: @merchant_2)
      @item_4 = create(:item, merchant: @merchant_2)

      @invoice_1 = create(:invoice)
      @invoice_2 = create(:invoice)
      @invoice_3 = create(:invoice)
      @invoice_4 = create(:invoice)

      @invoice_1.items << [@item_1, @item_2, @item_3]
      @invoice_2.items << [@item_3, @item_4]
      @invoice_3.items << [@item_1, @item_4]
      @invoice_4.items << @item_2
    end

    describe '.invoices' do
      it 'returns a list of invoices which contain an item from the merchant' do
        expect(@merchant_1.distinct_invoices).to match_array([@invoice_1, @invoice_3, @invoice_4])
        expect(@merchant_2.distinct_invoices).to match_array([@invoice_1, @invoice_2, @invoice_3])
      end
    end

    describe 'top 5 customers' do
      before :each do
        @customer_1 = create(:customer)
        @customer_2 = create(:customer)
        @customer_3 = create(:customer)
        @customer_4 = create(:customer)
        @customer_5 = create(:customer)
        @customer_6 = create(:customer)
        @customer_7 = create(:customer)
        @customer_8 = create(:customer)

        @invoice_1 = create(:invoice, customer: @customer_1)
        @invoice_2 = create(:invoice, customer: @customer_2)
        @invoice_3 = create(:invoice, customer: @customer_3)
        @invoice_4 = create(:invoice, customer: @customer_4)
        @invoice_5 = create(:invoice, customer: @customer_5)
        @invoice_6 = create(:invoice, customer: @customer_6)
        @invoice_7 = create(:invoice, customer: @customer_7)
        @invoice_8 = create(:invoice, customer: @customer_8)
        @invoice_9 = create(:invoice, customer: @customer_5)
        @invoice_10 = create(:invoice, customer: @customer_6)
        @invoice_11 = create(:invoice, customer: @customer_4)
        @invoice_12 = create(:invoice, customer: @customer_4)
        @invoice_13 = create(:invoice, customer: @customer_4)
        @invoice_14 = create(:invoice, customer: @customer_6)
        @invoice_15 = create(:invoice, customer: @customer_4)
        @invoice_16 = create(:invoice, customer: @customer_4)
        @invoice_17 = create(:invoice, customer: @customer_5)
        @invoice_18 = create(:invoice,customer: @customer_5)
        @invoice_19 = create(:invoice,customer: @customer_6)
        @invoice_20 = create(:invoice,customer: @customer_6)
        @invoice_21 = create(:invoice,customer: @customer_7)
        @invoice_22 = create(:invoice,customer: @customer_7)
        @invoice_23 = create(:invoice,customer: @customer_8)

        @merchant_1 = create(:merchant)
        @merchant_2 = create(:merchant)

        @item_1 = create(:item, merchant: @merchant_1)
        @item_2 = create(:item, merchant: @merchant_2)

        @invoice_1.items << @item_1
        @invoice_2.items << @item_1
        @invoice_3.items << @item_1
        @invoice_4.items << @item_1
        @invoice_5.items << @item_1
        @invoice_6.items << @item_1
        @invoice_7.items << @item_1
        @invoice_8.items << @item_1
        @invoice_9.items << @item_1
        @invoice_10.items << @item_1
        @invoice_11.items << @item_1
        @invoice_12.items << @item_1
        @invoice_13.items << @item_1
        @invoice_14.items << @item_1
        @invoice_15.items << @item_1
        @invoice_16.items << @item_1
        @invoice_17.items << @item_1
        @invoice_18.items << @item_1
        @invoice_19.items << @item_1
        @invoice_20.items << @item_1
        @invoice_21.items << @item_1
        @invoice_22.items << @item_1
        @invoice_23.items << @item_1

        @transaction_1 = create(:transaction, invoice: @invoice_1, result: :failed)
        @transaction_2 = create(:transaction, invoice: @invoice_1, result: :success) #merch_1 cust_1
        @transaction_3 = create(:transaction, invoice: @invoice_2, result: :success) #merch_1 cust_2
        @transaction_4 = create(:transaction, invoice: @invoice_3, result: :success) #merch_1 cust_3
        @transaction_5 = create(:transaction, invoice: @invoice_4, result: :success) #merch_1 cust_4
        @transaction_6 = create(:transaction, invoice: @invoice_5, result: :success) #merch_1&2 cust_5
        @transaction_7 = create(:transaction, invoice: @invoice_6, result: :success) #mercht_1&2 cust_6
        @transaction_8 = create(:transaction, invoice: @invoice_7, result: :success) #merch_1 cust_7
        @transaction_9 = create(:transaction, invoice: @invoice_8, result: :success) #merch_1 cust_8
        @transaction_10 = create(:transaction, invoice: @invoice_9, result: :success) #merch_1 cust 5
        @transaction_11 = create(:transaction, invoice: @invoice_10, result: :success) #merch_1 cust 6
        @transaction_12 = create(:transaction, invoice: @invoice_11, result: :success) #merch_1 cust 4
        @transaction_13 = create(:transaction, invoice: @invoice_12, result: :success) #merch_1 cust 4
        @transaction_14 = create(:transaction, invoice: @invoice_13, result: :success) #merch_1 cust 4
        @transaction_15 = create(:transaction, invoice: @invoice_14, result: :success) #merch_1 cust 6
        @transaction_16 = create(:transaction, invoice: @invoice_15, result: :success) #merch_1 cust 4
        @transaction_17 = create(:transaction, invoice: @invoice_16, result: :success) #merch_1 cust 4
        @transaction_18 = create(:transaction, invoice: @invoice_17, result: :success) #merch_1 cust 5
        @transaction_19 = create(:transaction, invoice: @invoice_18, result: :success) #merch_1 cust_5
        @transaction_20 = create(:transaction, invoice: @invoice_19, result: :success) #merch_1 cust_6
        @transaction_21 = create(:transaction, invoice: @invoice_20, result: :success) #merch_1 cust_6
        @transaction_22 = create(:transaction, invoice: @invoice_21, result: :success) #merch_1 cust_7
        @transaction_23 = create(:transaction, invoice: @invoice_22, result: :success) #merch_1 cust_7
        @transaction_24 = create(:transaction, invoice: @invoice_23, result: :success) #merch_1 cust_8
      end
      it 'returns the top 5 customers by successful transactions with the merchant' do
        expect(@merchant_1.top_five_customers).to eq([@customer_4, @customer_6, @customer_5, @customer_7, @customer_8])
        expect(@merchant_1.top_five_customers[0].transaction_count).to eq(6)
        expect(@merchant_1.top_five_customers[1].transaction_count).to eq(5)
        expect(@merchant_1.top_five_customers[2].transaction_count).to eq(4)
        expect(@merchant_1.top_five_customers[3].transaction_count).to eq(3)
        expect(@merchant_1.top_five_customers[4].transaction_count).to eq(2)
      end

      it 'doesnt count failed trasnactions' do
        invoice_24 = create(:invoice, customer: @customer_6)
        invoice_25 = create(:invoice, customer: @customer_6)
        
        invoice_24.items << @item_1
        invoice_25.items << @item_1
        
        transaction_25 = create(:transaction, invoice: invoice_24, result: :failed)
        transaction_26 = create(:transaction, invoice: invoice_25, result: :failed)
        
        expect(@merchant_1.top_five_customers).to eq([@customer_4, @customer_6, @customer_5, @customer_7, @customer_8])
      end
      
      it 'doesnt count other merchant transactions' do
        merchant_2 = create(:merchant)
        item_2 = create(:item, merchant: merchant_2)
        
        invoice_24 = create(:invoice, customer: @customer_6)
        invoice_25 = create(:invoice, customer: @customer_6)
        
        invoice_24.items << item_2
        invoice_25.items << item_2
        
        transaction_25 = create(:transaction, invoice: invoice_24, result: :success)
        transaction_26 = create(:transaction, invoice: invoice_25, result: :success)
        
        expect(@merchant_1.top_five_customers).to eq([@customer_4, @customer_6, @customer_5, @customer_7, @customer_8])
      end
    end
  end

  describe 'test instance variables for .top_five_revenue' do
    before(:each) do
      @merch1 = create(:merchant)
      @item1 = create(:item, merchant: @merch1, unit_price: 5700)
      @item2 = create(:item, merchant: @merch1)
  
      @merch2 = create(:merchant)
      @item3 = create(:item, merchant: @merch2, unit_price: 500)
      @item4 = create(:item, merchant: @merch2, unit_price: 500)
      @item5 = create(:item, merchant: @merch2, unit_price: 500)
      @item6 = create(:item, merchant: @merch2, unit_price: 500)
      @item7 = create(:item, merchant: @merch2, unit_price: 500)
      @item8 = create(:item, merchant: @merch2, unit_price: 500)
      @item9 = create(:item, merchant: @merch2, unit_price: 500)
  
      @invoice1 = create(:invoice, status: :completed)
      @invoice2 = create(:invoice, status: :completed)
      @invoice3 = create(:invoice, status: :completed)
      @invoice4 = create(:invoice, status: :completed)
      @invoice5 = create(:invoice, status: :completed)
  
      @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item3, quantity: 10, unit_price: 100, status: :packaged)
      @inv_item2 = create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 11, unit_price: 100, status: :packaged)
      @inv_item3 = create(:invoice_item, invoice: @invoice3, item: @item5, quantity: 12, unit_price: 100, status: :packaged)
      @inv_item4 = create(:invoice_item, invoice: @invoice4, item: @item6, quantity: 13, unit_price: 100, status: :packaged)
      @inv_item5 = create(:invoice_item, invoice: @invoice5, item: @item7, quantity: 14, unit_price: 100, status: :packaged)
      @inv_item6 = create(:invoice_item, invoice: @invoice1, item: @item8, quantity: 15, unit_price: 100, status: :packaged)
      @inv_item7 = create(:invoice_item, invoice: @invoice2, item: @item9, quantity: 16, unit_price: 100, status: :packaged)
      @inv_item8 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 10, unit_price: 100, status: :packaged)
      @inv_item9 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 11, unit_price: 100, status: :packaged)
      @inv_item10 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 12, unit_price: 100, status: :packaged)
  
      @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: :success)
      @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: :failed)
      @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: :success)
      @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: :success)
      @transaction5 = create(:transaction, invoice_id: @invoice5.id, result: :success)
      @transaction6 = create(:transaction, invoice_id: @invoice1.id, result: :success)
      @transaction7 = create(:transaction, invoice_id: @invoice2.id, result: :failed)
      @transaction8 = create(:transaction, invoice_id: @invoice3.id, result: :failed)
      @transaction9 = create(:transaction, invoice_id: @invoice4.id, result: :failed)
      @transaction10 = create(:transaction, invoice_id: @invoice5.id, result: :failed)
    end
    
    it '.top_five_revenue' do
      expect(@merch2.top_five_revenue).to match_array([@item5, @item7, @item3, @item6, @item8])
      expect(@merch2.top_five_revenue).to eq([@item3, @item8, @item5, @item7, @item6])
    end
  end

end
