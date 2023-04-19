require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'methods' do
    before(:each) do
      test_data
      @transaction_21 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_22 = @invoice_2.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_23 = @invoice_3.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_24 = @invoice_4.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_25 = @invoice_5.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_26 = @invoice_6.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_27 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_28 = @invoice_8.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_29 = @invoice_9.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_30 = @invoice_10.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_31 = @invoice_11.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_32 = @invoice_12.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_33 = @invoice_13.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_34 = @invoice_14.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_35 = @invoice_15.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_36 = @invoice_16.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_37 = @invoice_17.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_38 = @invoice_18.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_39 = @invoice_19.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_40 = @invoice_20.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @invoice_item_53 = @invoice_13.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_54 = @invoice_14.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_55 = @invoice_15.invoice_items.create!(item: @item_26, quantity: 1, unit_price: 2200, status: 1)
      @invoice_item_56 = @invoice_16.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_57 = @invoice_17.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_58 = @invoice_18.invoice_items.create!(item: @item_30, quantity: 1, unit_price: 2300, status: 1)
      @invoice_item_59 = @invoice_19.invoice_items.create!(item: @item_35, quantity: 1, unit_price: 2400, status: 1)
      @invoice_item_60 = @invoice_20.invoice_items.create!(item: @item_35, quantity: 1, unit_price: 2400, status: 1)
      
    end

    it '#can find top 5 customers' do
      expect(@merchant_1.top_five_customers).to eq([@customer_6, @customer_1, @customer_2, @customer_5, @customer_3])  
      expect(@merchant_1.top_five_customers.first.transaction_count).to eq(14)
    end

    it '#can find a merchants total revenue' do
      expect(@merchant_3.total_revenue).to eq(226800)
      expect(@merchant_1.total_revenue).to eq(151200)
      expect(@merchant_5.total_revenue).to eq(70200)
      expect(@merchant_2.total_revenue).to eq(42000)
      expect(@merchant_4.total_revenue).to eq(39600)
      expect(@merchant_6.total_revenue).to eq(0)
    end

    it '#revenue_usd' do
      expect(@merchant_3.revenue_usd).to eq(2268.0)
      expect(@merchant_1.revenue_usd).to eq(1512.0)
      expect(@merchant_5.revenue_usd).to eq(702.0)
      expect(@merchant_2.revenue_usd).to eq(420.0)
      expect(@merchant_4.revenue_usd).to eq(396.0)
      expect(@merchant_6.revenue_usd).to eq(0)
    end

    it '::can find top 5 merchants' do
      expect(Merchant.top_five_merchants.first).to eq(@merchant_3)
    end

    it "#update_status" do
      expect(@merchant_3.status).to eq("disabled")

      @merchant_3.update_status("enabled")

      expect(@merchant_3.status).to eq("enabled")

      @merchant_3.update_status("disabled")

      expect(@merchant_3.status).to eq("disabled")
    end

    it "#top_day" do
    @invoice_item_61 = @invoice_4.invoice_items.create!(item: @item_35, quantity: 1000, unit_price: 2400, status: 1)
      @invoice_1.update(created_at: "06/04/2023")
      @invoice_item_1.update(quantity: 1000)
      @invoice_8.update(created_at: "16/04/2023")
      @invoice_item_28.update(quantity: 1000)
      @invoice_12.update(created_at: "09/04/2023")
      @invoice_item_32.update(quantity: 1000)
      @invoice_13.update(created_at: "31/03/2023")
      @invoice_item_53.update(quantity: 10000)
      @invoice_4.update(created_at: "27/03/2023")
 

    expect(@merchant_1.top_day).to eq("04/06/2023")
    expect(@merchant_2.top_day).to eq("04/16/2023")
    expect(@merchant_3.top_day).to eq("04/09/2023")
    expect(@merchant_4.top_day).to eq("03/31/2023")
    expect(@merchant_5.top_day).to eq("03/27/2023")
    end
  end
end