require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  before :each do
    @merchant_1 = create(:merchant)
    @item = create(:item, merchant: @merchant_1)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @customer_7 = create(:customer)
    @customer_8 = create(:customer)

    @invoice_1 = create(:invoice, status: :completed, customer: @customer_1)
    @invoice_2 = create(:invoice, status: :completed, customer: @customer_2)
    @invoice_3 = create(:invoice, status: :completed, customer: @customer_3)
    @invoice_4 = create(:invoice, status: :completed, customer: @customer_4)
    @invoice_5 = create(:invoice, status: :completed, customer: @customer_5)
    @invoice_6 = create(:invoice, status: :completed, customer: @customer_6)
    @invoice_7 = create(:invoice, status: :completed, customer: @customer_7)
    @invoice_8 = create(:invoice, status: :completed, customer: @customer_8)
    # customer_1 transactions
    @transaction_1 = create(:transaction, result: :failed, invoice: @invoice_1)
    @transaction_2 = create(:transaction, result: :failed, invoice: @invoice_1)
    @transaction_3 = create(:transaction, result: :failed, invoice: @invoice_1)
    @transaction_4 = create(:transaction, result: :success, invoice: @invoice_1)
    @transaction_5 = create(:transaction, result: :success, invoice: @invoice_1)
    @transaction_6 = create(:transaction, result: :success, invoice: @invoice_1)
    @transaction_7 = create(:transaction, result: :success, invoice: @invoice_1)
    @transaction_8 = create(:transaction, result: :success, invoice: @invoice_1)
    # customer_2 transactions
    @transaction_9 = create(:transaction, result: :failed, invoice: @invoice_2)
    @transaction_10 = create(:transaction, result: :success, invoice: @invoice_2)
    @transaction_11 = create(:transaction, result: :success, invoice: @invoice_2)
    @transaction_12 = create(:transaction, result: :success, invoice: @invoice_2)
    @transaction_13 = create(:transaction, result: :success, invoice: @invoice_2)
    @transaction_14 = create(:transaction, result: :success, invoice: @invoice_2)
    @transaction_15 = create(:transaction, result: :success, invoice: @invoice_2)
    @transaction_16 = create(:transaction, result: :success, invoice: @invoice_2)
    # customer_3 transactions
    @transaction_17 = create(:transaction, result: :success, invoice: @invoice_3)
    @transaction_18 = create(:transaction, result: :success, invoice: @invoice_3)
    @transaction_19 = create(:transaction, result: :success, invoice: @invoice_3)
    @transaction_20 = create(:transaction, result: :success, invoice: @invoice_3)
    @transaction_21 = create(:transaction, result: :success, invoice: @invoice_3)
    @transaction_22 = create(:transaction, result: :success, invoice: @invoice_3)
    @transaction_23 = create(:transaction, result: :failed, invoice: @invoice_3)
    @transaction_24 = create(:transaction, result: :failed, invoice: @invoice_3)
    # customer_4 transactions
    @transaction_25 = create(:transaction, result: :success, invoice: @invoice_4)
    @transaction_26 = create(:transaction, result: :success, invoice: @invoice_4)
    @transaction_27 = create(:transaction, result: :success, invoice: @invoice_4)
    @transaction_28 = create(:transaction, result: :success, invoice: @invoice_4)
    @transaction_29 = create(:transaction, result: :success, invoice: @invoice_4)
    @transaction_30 = create(:transaction, result: :success, invoice: @invoice_4)
    @transaction_31 = create(:transaction, result: :success, invoice: @invoice_4)
    @transaction_32 = create(:transaction, result: :success, invoice: @invoice_4)
    # customer_5 transactions
    @transaction_33 = create(:transaction, result: :failed, invoice: @invoice_5)
    @transaction_34 = create(:transaction, result: :failed, invoice: @invoice_5)
    @transaction_35 = create(:transaction, result: :failed, invoice: @invoice_5)
    @transaction_36 = create(:transaction, result: :failed, invoice: @invoice_5)
    # customer_6 transactions
    @transaction_37 = create(:transaction, result: :success, invoice: @invoice_6)
    @transaction_38 = create(:transaction, result: :success, invoice: @invoice_6)
    @transaction_39 = create(:transaction, result: :success, invoice: @invoice_6)
    @transaction_40 = create(:transaction, result: :failed, invoice: @invoice_6)
    # customer_7 transactions
    @transaction_41 = create(:transaction, result: :failed, invoice: @invoice_7)
    @transaction_42 = create(:transaction, result: :success, invoice: @invoice_7)
    @transaction_43 = create(:transaction, result: :success, invoice: @invoice_7)
    @transaction_44 = create(:transaction, result: :success, invoice: @invoice_7)
    # customer_8 transactions
    @transaction_45 = create(:transaction, result: :success, invoice: @invoice_8)
    @transaction_46 = create(:transaction, result: :success, invoice: @invoice_8)
    @transaction_47 = create(:transaction, result: :success, invoice: @invoice_8)
    @transaction_48 = create(:transaction, result: :success, invoice: @invoice_8)

    create(:invoice_items, item: @item, invoice: @invoice_1)
    create(:invoice_items, item: @item, invoice: @invoice_2)
    create(:invoice_items, item: @item, invoice: @invoice_3)
    create(:invoice_items, item: @item, invoice: @invoice_4)
    create(:invoice_items, item: @item, invoice: @invoice_5)
    create(:invoice_items, item: @item, invoice: @invoice_6)
    create(:invoice_items, item: @item, invoice: @invoice_7)
    create(:invoice_items, item: @item, invoice: @invoice_8)
  end

  describe 'class methods' do
    it 'has top_5_customers method' do
      expect(Customer.top_5_customers).to eq([@customer_4, @customer_2, @customer_3, @customer_1, @customer_8])
    end

    it 'the top_5_cust_by_merch method' do
      expect(Customer.top_5_cust_by_merch(@merchant_1.id)).to eq([@customer_4, @customer_2, @customer_3, @customer_1, @customer_8])
    end
  end
end
