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

  before(:each) do
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_1.id, enabled: false)
    @item_5 = create(:item, merchant_id: @merchant_1.id, enabled: false)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_2.id)
    @invoice_4 = create(:invoice, customer_id: @customer_3.id)
    @invoice_5 = create(:invoice, customer_id: @customer_4.id)
    @invoice_6 = create(:invoice, customer_id: @customer_5.id)
    @invoice_7 = create(:invoice, customer_id: @customer_6.id)

    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: true) #customer_1
    @transaction_2 = create(:transaction, invoice_id: @invoice_1.id, result: true) #customer_1
    @transaction_3 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
    @transaction_4 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
    @transaction_5 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
    @transaction_6 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
    @transaction_7 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_8 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_9 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_10 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_11 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_12 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
    @transaction_13 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
    @transaction_14 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
    @transaction_15 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
    @transaction_16 = create(:transaction, invoice_id: @invoice_5.id, result: true) #customer_4
    @transaction_17 = create(:transaction, invoice_id: @invoice_5.id, result: true) #customer_4
    @transaction_18 = create(:transaction, invoice_id: @invoice_5.id, result: true) #customer_4
    @transaction_19 = create(:transaction, invoice_id: @invoice_6.id, result: true) #customer_5
    @transaction_20 = create(:transaction, invoice_id: @invoice_6.id, result: true) #customer_5
    @transaction_21= create(:transaction, invoice_id: @invoice_6.id, result: false) #customer_5
    @transaction_22 = create(:transaction, invoice_id: @invoice_7.id, result: true) #customer_6
    @transaction_23 = create(:transaction, invoice_id: @invoice_7.id, result: false) #customer_6

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: 0)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, status: 1)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: 2)
    @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: 2)
    @invoice_item_6 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_6.id, status: 2)
    @invoice_item_7 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_7.id, status: 2)
  end

  describe "instance methods" do
    describe '#top_five_customers' do
      it 'returns the top five customers for a merchant' do
        expect(@merchant_1.top_five_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end
    end

    describe '#items_not_shipped' do
      it 'returns the items that have not been shipped' do
        expect(@merchant_1.items_not_shipped).to eq([@invoice_item_1, @invoice_item_2, @invoice_item_3])
      end
    end

    describe '#enabled_items' do
      it 'returns only the merchant\'s items that are enabled' do
        expect(@merchant_1.enabled_items).to eq([@item_1, @item_2, @item_3])
      end
    end

    describe '#disabled_items' do
      it 'returns only the merchant\'s items that are disabled' do
        expect(@merchant_1.disabled_items).to eq([@item_4, @item_5])
      end
    end
  end
end
