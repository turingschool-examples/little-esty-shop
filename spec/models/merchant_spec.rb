require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    
# FROM 38merchantfavcustomers BRANCH ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id)
    @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    @invoice_5 = create(:invoice, customer_id: @customer_5.id)
    @invoice_6 = create(:invoice, customer_id: @customer_6.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id)
    @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_4.id)
    @invoice_item_5 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_5.id)
    @invoice_item_6 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id)


    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 0)
    @transaction_2 = create(:transaction, invoice_id: @invoice_1.id, result: 0)
    @transaction_3 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_4 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_5 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_6 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_7 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_8 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_9 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_10 = create(:transaction, invoice_id: @invoice_1.id, result: 1)

    @transaction_11 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_12 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_13 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_14 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_15 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_16 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_17 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_18 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_19 = create(:transaction, invoice_id: @invoice_2.id, result: 1)

    @transaction_20 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_21 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_22 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_23 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_24 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_25 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_26 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_27 = create(:transaction, invoice_id: @invoice_3.id, result: 1)

    @transaction_28 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_29 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_30 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_31 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_32 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_33 = create(:transaction, invoice_id: @invoice_4.id, result: 1)

    @transaction_34 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_35 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_36 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_37 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_38 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    
# BRANCH 38 END ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    
#   @merchant_1 = create(:merchant, name: "M1")
#   @merchant_2 = create(:merchant, name: "M2")
#   @merchant_3 = create(:merchant, name: "M3")
#   @merchant_4 = create(:merchant, name: "M4")
#   @merchant_5 = create(:merchant, name: "M5")

#   @customer_1 = FactoryBot.create(:customer)
#   @customer_2 = FactoryBot.create(:customer)
#   @customer_3 = FactoryBot.create(:customer)
#   @customer_4 = FactoryBot.create(:customer)
#   @customer_5 = FactoryBot.create(:customer)
#   @customer_6 = FactoryBot.create(:customer)

#   @item_1 = create(:item, merchant: @merchant_1)
#   @item_2 = create(:item, merchant: @merchant_2)
#   @item_3 = create(:item, merchant: @merchant_3)
#   @item_4 = create(:item, merchant: @merchant_4)
#   @item_5 = create(:item, merchant: @merchant_5)

#   @invoice_1 = FactoryBot.create(:invoice)
#   @invoice_2 = FactoryBot.create(:invoice)
#   @invoice_3 = FactoryBot.create(:invoice)
#   @invoice_4 = FactoryBot.create(:invoice)
#   @invoice_5 = FactoryBot.create(:invoice)
#   @invoice_6 = FactoryBot.create(:invoice)

#   @customer_1.invoices << [@invoice_1]
#   @customer_2.invoices << [@invoice_2]
#   @customer_3.invoices << [@invoice_3]
#   @customer_4.invoices << [@invoice_4]
#   @customer_5.invoices << [@invoice_5]
#   @customer_6.invoices << [@invoice_6]

#   @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: "packaged", quantity: 1, unit_price: 30)
#   @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: "pending", quantity: 5, unit_price: 20)
#   @invoice_item_3 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id, status: "pending", quantity: 10, unit_price: 10)
#   @invoice_item_4 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_2.id, status: "packaged", quantity: 20, unit_price: 5)
#   @invoice_item_5 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_3.id, status: "packaged", quantity: 40, unit_price: 5)
#   @invoice_item_6 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: "packaged", quantity: 60, unit_price: 5)
#   @invoice_item_7 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 80, unit_price: 5)
#   @invoice_item_8 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_6.id, status: "packaged", quantity: 100, unit_price: 5)

#   @transaction_1 = FactoryBot.create(:transaction, result: 1)
#   @transaction_2 = FactoryBot.create(:transaction, result: 1)
#   @transaction_3 = FactoryBot.create(:transaction, result: 1)
#   @transaction_4 = FactoryBot.create(:transaction, result: 1)
#   @transaction_5 = FactoryBot.create(:transaction, result: 1)
#   @invoice_1.transactions << [@transaction_1, @transaction_2, @transaction_3, @transaction_4, @transaction_5]

#   @transaction_6 = FactoryBot.create(:transaction, result: 1)
#   @transaction_7 = FactoryBot.create(:transaction, result: 1)
#   @transaction_8 = FactoryBot.create(:transaction, result: 1)
#   @transaction_9 = FactoryBot.create(:transaction, result: 1)
#   @invoice_2.transactions << [@transaction_6, @transaction_7, @transaction_8, @transaction_9]

#   @transaction_10 = FactoryBot.create(:transaction, result: 1)
#   @transaction_11 = FactoryBot.create(:transaction, result: 1)
#   @transaction_12 = FactoryBot.create(:transaction, result: 1)
#   @invoice_3.transactions << [@transaction_10, @transaction_11, @transaction_12]

#   @transaction_13 = FactoryBot.create(:transaction, result: 1)
#   @transaction_14 = FactoryBot.create(:transaction, result: 1)
#   @invoice_4.transactions << [@transaction_13, @transaction_14]

#   @transaction_15 = FactoryBot.create(:transaction, result: 1)
#   @invoice_5.transactions << [@transaction_15]
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through :items }
    it { should have_many(:invoices).through :invoice_items }
    it { should have_many(:customers).through :invoices }
    it { should have_many(:transactions).through :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    it '#top_five_customers_by_successful_transaction_count' do
      expect(@merchant_1.top_five_customers_by_successful_transaction_count.to_a).to eq([@customer_2, @customer_1, @customer_3, @customer_4, @customer_5])
    end
  end
end
