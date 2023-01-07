require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_numericality_of(:unit_price)}
  end

  before(:each) do
    Transaction.delete_all
    InvoiceItem.delete_all
    Invoice.delete_all
    Item.delete_all
    Customer.delete_all
    Merchant.delete_all
    
    @customer_1 = create(:customer, first_name: "test customer 1")
    @customer_2 = create(:customer, first_name: "test customer 2")
    @customer_3 = create(:customer, first_name: "test customer 3")
    @customer_4 = create(:customer, first_name: "test customer 4")
    @customer_5 = create(:customer, first_name: "test customer 5")
    @customer_6 = create(:customer, first_name: "test customer 6")
    
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_6)
    @invoice_3 = create(:invoice, customer: @customer_2)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_4)
    @invoice_6 = create(:invoice, customer: @customer_5)
    @invoice_7 = create(:invoice, customer: @customer_6)
    @invoice_8 = create(:invoice, customer: @customer_6)
    @invoice_9 = create(:invoice, customer: @customer_5)
    @invoice_10 = create(:invoice, customer: @customer_2)
    @invoice_11 = create(:invoice, customer: @customer_6)
    @invoice_12 = create(:invoice, customer: @customer_4)
    @invoice_13 = create(:invoice, customer: @customer_5)
    @invoice_14 = create(:invoice, customer: @customer_6)
    @invoice_15 = create(:invoice, customer: @customer_4)
    @invoice_16 = create(:invoice, customer: @customer_6)
    
    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: "success")
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: "success")
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: "success")
    @transaction_9 = create(:transaction, invoice: @invoice_9, result: "success")
    @transaction_10 = create(:transaction, invoice: @invoice_10, result: "success")
    @transaction_11 = create(:transaction, invoice: @invoice_11, result: "success")
    @transaction_13 = create(:transaction, invoice: @invoice_13, result: "failed")
    @transaction_14 = create(:transaction, invoice: @invoice_14, result: "failed")
    @transaction_15 = create(:transaction, invoice: @invoice_15, result: "success")
    @transaction_16 = create(:transaction, invoice: @invoice_16, result: "success")

    @merchant_1 = create(:merchant, name: "merchant 1")
    @merchant_2 = create(:merchant, name: "merchant 2")
    @merchant_3 = create(:merchant, name: "merchant 3")

    @item_1 = create(:item, name: "item 1 - merch 1", merchant: @merchant_1)
    @item_2 = create(:item, name: "item 2 - merch 1", merchant: @merchant_1)
    @item_3 = create(:item, name: "item 3 - merch 1",  merchant: @merchant_1)
    @item_4 = create(:item, name: "item 4",  merchant: @merchant_2)
    @item_5 = create(:item, name: "item 5",  merchant: @merchant_2)
    @item_6 = create(:item, name: "item 6",  merchant: @merchant_3)
    @item_7 = create(:item, name: "item 7",  merchant: @merchant_3)
    @item_8 = create(:item, name: "item 8",  merchant: @merchant_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, status: "shipped")
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_6, status: "shipped" )
    @invoice_item_3 = create(:invoice_item, item: @item_2, invoice: @invoice_11, status: "pending" )
    @invoice_item_4 = create(:invoice_item, item: @item_5, invoice: @invoice_2, status: "packaged" )
    @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_2, status: "shipped" )
    @invoice_item_6 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: "pending" )
    @invoice_item_7 = create(:invoice_item, item: @item_1, invoice: @invoice_16, status: "shipped" )
    @invoice_item_8 = create(:invoice_item, item: @item_8, invoice: @invoice_3, status: "packaged" )
    @invoice_item_9 = create(:invoice_item, item: @item_3, invoice: @invoice_4, status: "packaged" )
    @invoice_item_10 = create(:invoice_item, item: @item_2, invoice: @invoice_15, status: "packaged" )
    @invoice_item_11 = create(:invoice_item, item: @item_7, invoice: @invoice_5, status: "packaged" )
    @invoice_item_12 = create(:invoice_item, item: @item_3, invoice: @invoice_11, status: "pending" )
    @invoice_item_13 = create(:invoice_item, item: @item_2, invoice: @invoice_12, status: "packaged" )
    @invoice_item_14 = create(:invoice_item, item: @item_8, invoice: @invoice_7, status: "packaged" )
    @invoice_item_15 = create(:invoice_item, item: @item_1, invoice: @invoice_8, status: "pending" )
    @invoice_item_16 = create(:invoice_item, item: @item_6, invoice: @invoice_9, status: "packaged" )
    @invoice_item_17 = create(:invoice_item, item: @item_7, invoice: @invoice_10, status: "pending" )
    @invoice_item_18 = create(:invoice_item, item: @item_2, invoice: @invoice_11, status: "packaged" )
  end

  #Q4
  # it "returns items with the status 'packaged'" do
  #   require 'pry';binding.pry
  #   expect(@merchant_1.ready_to_ship).to eq([@item_2, @item_3]) 
  # end

end