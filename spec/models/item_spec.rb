require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_numericality_of(:unit_price)}
  end

  it 'has a method to toggle item status' do
    item = Item.new(name: "item test", description: "this is a test item", unit_price: 4, status: "Disabled")
    item.toggle_status
    expect(item.status).to eq("Enabled")

    item.toggle_status
    expect(item.status).to eq("Disabled")
  end

  it 'has a method to find all instances of itself associated with a certain merchant and status' do
    merchant = Merchant.create!(name: "Test Merchant")
    item1 = Item.create!(name: "item test", description: "this is a test item", unit_price: 4, status: "Disabled", merchant_id: merchant.id)
    item2 = Item.create!(name: "item test", description: "this is a test item", unit_price: 4, status: "Disabled", merchant_id: merchant.id)
    item3 = Item.create!(name: "item test", description: "this is a test item", unit_price: 4, status: "Enabled", merchant_id: merchant.id)
    item4 = Item.create!(name: "item test", description: "this is a test item", unit_price: 4, status: "Enabled", merchant_id: merchant.id)

    expect(Item.find_merchant_items_by_status(merchant.id, "Enabled")).to eq([item3, item4])
    expect(Item.find_merchant_items_by_status(merchant.id, "Disabled")).to eq([item1, item2])
  end

  describe "13. Merchant Items Index: Top Item's Best Day" do
    before(:each) do
      Transaction.delete_all
      InvoiceItem.delete_all
      Invoice.delete_all
      Item.delete_all
      Customer.delete_all
      Merchant.delete_all
  
      @merchant_1 = create(:merchant, name: "merchant 1", status: "enabled")
      @merchant_2 = create(:merchant, name: "merchant 2", status: "disabled")
      @merchant_3 = create(:merchant, name: "merchant 3", status: "enabled")
      @merchant_4 = create(:merchant, name: "merchant 4", status: "disabled")
  
      @customer_1 = create(:customer, first_name: "Customer 1")
      @customer_2 = create(:customer, first_name: "Customer 2")
      @customer_3 = create(:customer, first_name: "Customer 3")
      @customer_4 = create(:customer, first_name: "Customer 4")
  
      @invoice_1 = create(:invoice, customer: @customer_1, updated_at: Time.now - 5.years)
      @invoice_2 = create(:invoice, customer: @customer_2, updated_at: Time.now - 1.years)
      @invoice_3 = create(:invoice, customer: @customer_3, updated_at: Time.now - 3.years, status: 1)
      @invoice_4 = create(:invoice, customer: @customer_4, updated_at: Time.now - 30.days)
      @invoice_5 = create(:invoice, customer: @customer_1, updated_at: Time.now - 1.years)
      @invoice_6 = create(:invoice, customer: @customer_2, updated_at: Time.now - 31.days)
      @invoice_7 = create(:invoice, customer: @customer_3, updated_at: 10.hours.ago)
      @invoice_8 = create(:invoice, customer: @customer_4, updated_at: 20.seconds.ago)
  
      @item_1 = create(:item, merchant: @merchant_1, name: "plane 1")
      @item_2 = create(:item, merchant: @merchant_2, name: "plane 2")
      @item_3 = create(:item, merchant: @merchant_3, name: "plane 3")
      @item_4 = create(:item, merchant: @merchant_4, name: "plane 4")
      @item_5 = create(:item, merchant: @merchant_1, name: "plane 5")
      @item_6 = create(:item, merchant: @merchant_2, name: "plane 6")
      @item_7 = create(:item, merchant: @merchant_3, name: "plane 7")
      @item_8 = create(:item, merchant: @merchant_4, name: "plane 8")
  
      @item_9 = create(:item, merchant: @merchant_1, name: "plane 9")
      @item_10 = create(:item, merchant: @merchant_1, name: "plane 10")
      @item_11 = create(:item, merchant: @merchant_1, name: "plane 11")
      @item_12 = create(:item, merchant: @merchant_1, name: "plane 12")
      @item_13 = create(:item, merchant: @merchant_2, name: "plane 13")
      @item_14 = create(:item, merchant: @merchant_2, name: "plane 14")
      @item_15 = create(:item, merchant: @merchant_2, name: "plane 15")
      @item_16 = create(:item, merchant: @merchant_2, name: "plane 16")
  
      @invoice_item_1 = create(:invoice_item, unit_price: 1000, quantity: 1, item: @item_1, invoice: @invoice_1, status: "pending", updated_at: Time.now - 3.days)
      @invoice_item_2 = create(:invoice_item, unit_price: 900, quantity: 1, item: @item_2, invoice: @invoice_2, status: "pending", updated_at: Time.now - 3.days)
      @invoice_item_3 = create(:invoice_item, unit_price: 800, quantity: 5, item: @item_3, invoice: @invoice_3, status: "packaged", updated_at: Time.now - 3.days)
      @invoice_item_4 = create(:invoice_item, unit_price: 700, quantity: 1, item: @item_4, invoice: @invoice_4, status: "packaged", updated_at: Time.now - 33.days)
      @invoice_item_5 = create(:invoice_item, unit_price: 600, quantity: 5, item: @item_5, invoice: @invoice_5, status: "shipped", updated_at: Time.now - 33.days)
      @invoice_item_6 = create(:invoice_item, unit_price: 500, quantity: 1, item: @item_6, invoice: @invoice_6, status: "pending", updated_at: Time.now - 3.days)
      @invoice_item_7 = create(:invoice_item, unit_price: 400, quantity: 15, item: @item_2, invoice: @invoice_7, status: "packaged", updated_at: Time.now - 330.days)
      @invoice_item_8 = create(:invoice_item, unit_price: 300, quantity: 1, item: @item_1, invoice: @invoice_8, status: "shipped", updated_at: Time.now - 330.days)
      @invoice_item_9 = create(:invoice_item, unit_price: 200, quantity: 11, item: @item_5, invoice: @invoice_2, status: "pending", updated_at: Time.now - 3310.days)
      @invoice_item_10 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_5, invoice: @invoice_1, status: "shipped", updated_at: Time.now - 31.days)
      @invoice_item_11 = create(:invoice_item, unit_price: 100, quantity: 11, item: @item_1, invoice: @invoice_3, status: "pending", updated_at: Time.now - 31.days)
      @invoice_item_12 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: @invoice_5, status: "shipped", updated_at: Time.now - 310.days)
      @invoice_item_13 = create(:invoice_item, unit_price: 100, quantity: 12, item: @item_5, invoice: @invoice_3, status: "pending", updated_at: Time.now - 310.days)
      @invoice_item_14 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_1, invoice: @invoice_7, status: "packaged", updated_at: Time.now - 130.days)
      @invoice_item_15 = create(:invoice_item, unit_price: 100, quantity: 15, item: @item_2, invoice: @invoice_4, status: "packaged", updated_at: Time.now - 301.days)
      @invoice_item_16 = create(:invoice_item, unit_price: 100, quantity: 18, item: @item_6, invoice: @invoice_8, status: "shipped", updated_at: Time.now - 301.days)
      @invoice_item_17 = create(:invoice_item, unit_price: 100, quantity: 19, item: @item_9, invoice: @invoice_2, status: "packaged", updated_at: Time.now - 301.days)
      @invoice_item_18 = create(:invoice_item, unit_price: 100, quantity: 11, item: @item_9, invoice: @invoice_6, status: "shipped", updated_at: Time.now - 310.days)
    
      @invoice_item_19 = create(:invoice_item, unit_price: 100, quantity: 11, item: @item_9, invoice: @invoice_1, status: "shipped", updated_at: Time.now - 301.days)
      @invoice_item_20 = create(:invoice_item, unit_price: 100, quantity: 13, item: @item_10, invoice: @invoice_8, status: "pending", updated_at: Time.now - 301.days)
      @invoice_item_21 = create(:invoice_item, unit_price: 100, quantity: 14, item: @item_12, invoice: @invoice_2, status: "shipped", updated_at: Time.now - 310.days)
      @invoice_item_22 = create(:invoice_item, unit_price: 100, quantity: 1, item: @item_14, invoice: @invoice_6, status: "pending", updated_at: Time.now - 310.days)
      @invoice_item_23 = create(:invoice_item, unit_price: 100, quantity: 41, item: @item_13, invoice: @invoice_8, status: "packaged", updated_at: Time.now - 130.days)
      @invoice_item_24 = create(:invoice_item, unit_price: 100, quantity: 51, item: @item_15, invoice: @invoice_4, status: "packaged", updated_at: Time.now - 310.days)
      @invoice_item_25 = create(:invoice_item, unit_price: 100, quantity: 16, item: @item_12, invoice: @invoice_8, status: "shipped", updated_at: Time.now - 301.days)
      @invoice_item_26 = create(:invoice_item, unit_price: 100, quantity: 81, item: @item_10, invoice: @invoice_2, status: "packaged", updated_at: Time.now - 130.days)
      @invoice_item_27 = create(:invoice_item, unit_price: 100, quantity: 19, item: @item_16, invoice: @invoice_6, status: "shipped", updated_at: Time.now - 301.days)
      @invoice_item_28 = create(:invoice_item, unit_price: 100, quantity: 19, item: @item_9, invoice: @invoice_6, status: "shipped", updated_at: Time.now - 310.days)
    
      @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success", updated_at: Time.now - 2.years)
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success", updated_at: Time.now - 2.years)
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success", updated_at: Time.now - 5.days)
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success", updated_at: Time.now - 5.days)
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: "failed", updated_at: Time.now - 5.days)
      @transaction_6 = create(:transaction, invoice: @invoice_6, result: "success", updated_at: Time.now -  31.days)
      @transaction_7 = create(:transaction, invoice: @invoice_7, result: "success", updated_at: Time.now -  31.days)
      @transaction_8 = create(:transaction, invoice: @invoice_8, result: "success", updated_at: Time.now -  31.days)
      @transaction_9 = create(:transaction, invoice: @invoice_1, result: "failed")
      @transaction_10 = create(:transaction, invoice: @invoice_1, result: "success", updated_at: Time.now - 2.day)
      @transaction_11 = create(:transaction, invoice: @invoice_2, result: "success", updated_at: Time.now - 2.years)
      @transaction_12 = create(:transaction, invoice: @invoice_3, result: "success", updated_at: Time.now - 2.day)
      @transaction_13 = create(:transaction, invoice: @invoice_5, result: "success", updated_at: Time.now - 11.day)
      @transaction_14 = create(:transaction, invoice: @invoice_2, result: "failed")
      @transaction_15 = create(:transaction, invoice: @invoice_3, result: "success", updated_at: Time.now - 11.day)
      @transaction_16 = create(:transaction, invoice: @invoice_4, result: "success", updated_at: Time.now - 11.day)
    end
  
    it "returns the date with the most sales for each of the top 5 items" do
      expect(@item_1.item_top_sales_dates).to eq(@invoice_3.updated_at)
    end
  end
        
  end