require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
  end

  describe '::Class Methods' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant, status: 1)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant, status: 1)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
    end

    describe "::enabled_merchants" do
      it 'returns all merchants grouped by status type' do
        expect(Merchant.enabled_merchants).to eq([@merchant_1, @merchant_3, @merchant_5, @merchant_6])
      end
    end

    describe "::disabled_merchants" do
      it 'returns all merchants grouped by status type' do
        expect(Merchant.disabled_merchants).to eq([@merchant_2, @merchant_4])
      end
    end

    describe '::top_five_merchants_by_revenue' do
      it 'returns the top five merchants by revenue' do
        spendy_customer = create(:customer)

        item_1 = create(:item, merchant: @merchant_3)
        item_2 = create(:item, merchant: @merchant_1)
        item_3 = create(:item, merchant: @merchant_5)
        item_4 = create(:item, merchant: @merchant_2)
        item_5 = create(:item, merchant: @merchant_4)
        item_6 = create(:item, merchant: @merchant_6)

        invoice_1 = create(:invoice, customer: spendy_customer)
        invoice_2 = create(:invoice, customer: spendy_customer)
        invoice_3 = create(:invoice, customer: spendy_customer)
        invoice_4 = create(:invoice, customer: spendy_customer)
        invoice_5 = create(:invoice, customer: spendy_customer)
        invoice_6 = create(:invoice, customer: spendy_customer)
        invoice_7 = create(:invoice, customer: spendy_customer)
        invoice_8 = create(:invoice, customer: spendy_customer)
        invoice_9 = create(:invoice, customer: spendy_customer)
        invoice_10 = create(:invoice, customer: spendy_customer)
        invoice_11 = create(:invoice, customer: spendy_customer)
        invoice_12 = create(:invoice, customer: spendy_customer)
        
        create(:transaction, invoice: invoice_1, result: 0)
        create(:transaction, invoice: invoice_2, result: 0)
        create(:transaction, invoice: invoice_3, result: 1)
        create(:transaction, invoice: invoice_4, result: 0)
        create(:transaction, invoice: invoice_5, result: 0)
        create(:transaction, invoice: invoice_6, result: 1)
        create(:transaction, invoice: invoice_7, result: 0)
        create(:transaction, invoice: invoice_8, result: 0)
        create(:transaction, invoice: invoice_9, result: 1)
        create(:transaction, invoice: invoice_10, result: 0)
        create(:transaction, invoice: invoice_11, result: 0)
        create(:transaction, invoice: invoice_12, result: 0)


        #merchant 3 - 1900000 revenue
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 3, quantity: 300000)
        invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, unit_price: 2, quantity: 500000)
        invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3, unit_price: 1, quantity: 5000000)

        #merchant 1 - 5000000 revenue
        invoice_item_4 = create(:invoice_item, item: item_2, invoice: invoice_4, unit_price: 2, quantity: 2000000)
        invoice_item_5 = create(:invoice_item, item: item_2, invoice: invoice_5, unit_price: 2, quantity: 500000)
        invoice_item_6 = create(:invoice_item, item: item_2, invoice: invoice_6, unit_price: 2, quantity: 50000000)

        #merchant 5 - 10000000 revenue
        invoice_item_7 = create(:invoice_item, item: item_3, invoice: invoice_7, unit_price: 3, quantity: 2500000)
        invoice_item_8 = create(:invoice_item, item: item_3, invoice: invoice_8, unit_price: 5, quantity: 500000)
        invoice_item_9 = create(:invoice_item, item: item_3, invoice: invoice_9, unit_price: 2, quantity: 500000000)

        #merchant 2 - 1000000 revenue
        invoice_item_10 = create(:invoice_item, item: item_4, invoice: invoice_10, unit_price: 1, quantity: 1000000)

        #merchant 4 - 1500000 revenue 
        invoice_item_11 = create(:invoice_item, item: item_5, invoice: invoice_11, unit_price: 1, quantity: 1500000)

        #merchant 6 - 500000 revenue
        invoice_item_12 = create(:invoice_item, item: item_6, invoice: invoice_12, unit_price: 1, quantity: 500000)

        expect(Merchant.top_five_merchants_by_revenue).to eq([@merchant_5, @merchant_1, @merchant_3, @merchant_4, @merchant_2])
      end
    end
  end
  
  describe '#Instance Methods' do
    before(:each) do
      @merchant = create(:merchant, name: "Trader Bob's")

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)

      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1))
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: Date.new(2023,1,1))
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: Date.new(2023,1,1))
      @invoice_4 = create(:invoice, customer_id: @customer_4.id, created_at: Date.new(2023,1,2))
      @invoice_5 = create(:invoice, customer_id: @customer_5.id, created_at: Date.new(2023,1,2))
      @invoice_6 = create(:invoice, customer_id: @customer_6.id, created_at: Date.new(2023,1,3))
      @invoice_7 = create(:invoice, customer_id: @customer_6.id, created_at: Date.new(2023,1,4))

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @item_3 = create(:item, merchant: @merchant)
      
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: 40000,status: "packaged", created_at: "Sun, 25 Jan 2023 00:28:40")
      @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 1, unit_price: 40000,status: "packaged", created_at: "Mon, 26 Jan 2023 00:28:41")
      @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3, quantity: 1, unit_price: 40000,status: "packaged", created_at: "Tues, 27 Jan 2023 00:28:42")
      @invoice_item_4 = create(:invoice_item, item: @item_1, invoice: @invoice_4, quantity: 1, unit_price: 50000,status: "packaged", created_at: "Wed, 28 Jan 2023 00:28:43")
      @invoice_item_5 = create(:invoice_item, item: @item_1, invoice: @invoice_5, quantity: 1, unit_price: 50000,status: "packaged", created_at: "Thur, 29 Jan 2023 00:28:44")
      @invoice_item_6 = create(:invoice_item, item: @item_2, invoice: @invoice_6, quantity: 1, unit_price: 100000,status: "packaged", created_at: "Fri, 30 Jan 2023 00:28:45")
      @invoice_item_7 = create(:invoice_item, item: @item_3, invoice: @invoice_7, quantity: 1, unit_price: 1000000,status: "shipped", created_at: "Sat, 31 Jan 2023 00:28:46")
    end

    describe '#top_five_merchant_customers' do
      it 'returns the top five customers, ordered by successful transactions' do
        create(:transaction, invoice_id: @invoice_1.id, result: 0)
        2.times { create(:transaction, invoice_id: @invoice_2.id, result: 0) }
        3.times { create(:transaction, invoice_id: @invoice_3.id, result: 0) }
        4.times { create(:transaction, invoice_id: @invoice_4.id, result: 0) }
        5.times { create(:transaction, invoice_id: @invoice_5.id, result: 0) }
        3.times { create(:transaction, invoice_id: @invoice_7.id, result: 1) }
        expect(@merchant.top_five_merchant_customers).to eq([@customer_5, @customer_4, @customer_3, @customer_2, @customer_1])
      end
    end

    describe "#items_ready_to_ship" do
      it "returns all ordered items that have not been shiped from oldest to newest" do
        create(:transaction, invoice_id: @invoice_1.id, result: 0)
        2.times { create(:transaction, invoice_id: @invoice_2.id, result: 0) }
        3.times { create(:transaction, invoice_id: @invoice_3.id, result: 0) }
        4.times { create(:transaction, invoice_id: @invoice_4.id, result: 0) }
        5.times { create(:transaction, invoice_id: @invoice_5.id, result: 0) }
        3.times { create(:transaction, invoice_id: @invoice_7.id, result: 1) }
        expect(@merchant.invoice_items_ready_to_ship).to eq([@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_4, @invoice_item_5, @invoice_item_6])
      end
    end

    describe "#top_day" do
      it "returns the top day of sales for the merchant" do
        create(:transaction, invoice_id: @invoice_1.id, result: 0)
        create(:transaction, invoice_id: @invoice_2.id, result: 0)
        create(:transaction, invoice_id: @invoice_3.id, result: 0)
        create(:transaction, invoice_id: @invoice_4.id, result: 0)
        create(:transaction, invoice_id: @invoice_5.id, result: 0)
        create(:transaction, invoice_id: @invoice_7.id, result: 1)
 
        expect(@merchant.top_day_by_revenue.created_at).to eq("Sun, 01 Jan 2023 00:00:00 UTC +00:00")
      end
    end
  end
end
